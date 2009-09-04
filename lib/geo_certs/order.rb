module GeoCerts
  
  ##
  # Contains the details, attributes, and methods to interact with a GeoCerts order.
  # 
  class Order
    attr_accessor :completed_at,
                  :created_at,
                  :domain, 
                  :geotrust_order_id,
                  :id,
                  :licenses,
                  :sans,
                  :state,
                  :status_major,
                  :status_minor,
                  :total_price,
                  :years
    attr_reader   :csr,
                  :pending_audit,
                  :product,
                  :renewal,
                  :renewal_information,
                  :trial,
                  :warnings
    
    
    def self.all
      response = call_api { GeoCerts.api.orders }
      build_collection(response)
    end
    
    def self.find(id)
      new(call_api { GeoCerts.api.find_order(:id => id)[:order] })
    end
    
    def self.approvers(domain)
      response = call_api { GeoCerts.api.domain_approvers(:domain => domain) }
      collection = Collection.new
      response[:emails][:email].each { |email| collection << Email.new(email) }
      collection
    end
    
    def self.create(attributes = {})
      object = new(attributes)
      yield(object) if block_given?
      object.save
      object
    end
    
    def self.validate(attributes = {})
      object = new(attributes)
      yield(object) if block_given?
      object.validate
    end
    
    
    def initialize(attributes = {})
      attributes.each_pair do |name, value|
        send("#{name}=", value) if respond_to?(name)
      end
    end
    
    def modify!(action)
      self.class.call_api { GeoCerts.api.modify_order(:id => self.id, :state => action) }
    end
    
    def resend_approval_email!
      self.class.call_api { GeoCerts.api.resend_approval_email(:id => self.id) }
    end
    
    def change_approver_email!(email)
      self.class.call_api { GeoCerts.api.change_order_approval_email(:id => self.id, :approver_email => email) }
    end
    
    def validate
      parameters = {}
      parameters[:csr_body]     = CGI.escape(self.csr.body) if self.csr
      parameters[:product_sku]  = self.product.sku if self.product
      parameters[:years]        = self.years
      parameters[:licenses]     = self.licenses
      parameters[:sans]         = CGI.escape(self.sans) if self.sans
      
      Order.new(self.class.call_api {GeoCerts.api.validate_order(parameters)[:order]})
    end
    
    def save
      new_record? ? create : raise("Cannot update an existing Order")
    end
    
    def new_record?
      !self.id.nil?
    end
    
    alias :pending_audit? :pending_audit
    alias :renewal?       :renewal
    alias :trial?         :trial
    
    def pending_audit=(input) # :nodoc:
      @pending_audit = !!(input =~ /true/i)
    end
    
    def renewal=(input) # :nodoc:
      @renewal = !!(input =~ /true/i)
    end
    
    def trial=(input) # :nodoc:
      @trial = !!(input =~ /true/i)
    end
    
    def csr=(input)
      case input
      when CSR
        @csr = input
      when Hash
        @csr = CSR.new(input)
      end
    end
    
    def renewal_information=(input)
      case input
      when RenewalInformation
        @renewal_information = input
      when Hash
        @renewal_information = RenewalInformation.new(input)
      end
    end
    
    def product=(input)
      @product = input if input.kind_of?(Product)
    end
    
    def warnings=(input) # :nodoc:
      case input
      when Hash
        @warnings = input[:warning] if input.has_key?(:warning)
      end
    end
    
    
    private
    
    
    def create
      self.class.call_api do
        GeoCerts.api.create({
          
        })
      end
    end
    
    def self.build_collection(response)
      collection  = Collection.new
      collection.start_at = response[:start_at]
      collection.end_at   = response[:end_at]
      response[:orders][:order].each { |order| collection << new(order) }
      collection
    end
    
    def self.call_api
      yield if block_given?
    rescue RestClient::ResourceNotFound
      raise GeoCerts::ResourceNotFound.new($!)
    rescue RestClient::Unauthorized
      raise GeoCerts::Unauthorized.new($!)
    rescue RestClient::RequestFailed
      case $!.http_code
      when 422
        raise GeoCerts::UnprocessableEntity.new($!)
      when 400
        raise GeoCerts::BadRequest.new($!)
      else
        raise GeoCerts::RequestFailed.new($!)
      end
    rescue RestClient::RequestTimeout
      raise GeoCerts::RequestTimeout.new($!.message)
    rescue *GeoCerts::HTTP_ERRORS
      raise GeoCerts::ConnectionError.new($!.message)
    end

  end
  
end
