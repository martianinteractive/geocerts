require 'geo_certs/api_object'

module GeoCerts
  
  ##
  # Contains the information for a secure server certificate.  Generally, these objects would
  # be created and populated via GeoCerts::Order.certificate, unless you are looking for a 
  # listing of certificates in your account (see GeoCerts::Certificate.all).
  # 
  class Certificate < ApiObject
    
    attr_accessor :order_id,
                  :geotrust_order_id,
                  :status,
                  :certificate,
                  :ca_root,
                  :ca_intermediates,
                  :common_name,
                  :serial_number,
                  :start_at,
                  :end_at,
                  :city,
                  :state,
                  :country,
                  :organization,
                  :organizational_unit,
                  :approver_email,
                  :reissue_email,
                  :trial,
                  :url
    
    force_boolean :trial
    
    ##
    # Returns all certificates for a given window of time.  The server defaults to a 1 month
    # window.
    # 
    # === Options
    # 
    # :start_at:: The starting DateTime for the date range
    # :end_at:: The ending DateTime for the date range
    # 
    def self.all(options = {})
      prep_date_ranges!(options)
      response = call_api { GeoCerts.api.certificates(options) }
      build_collection(response) { |response| response[:certificates][:certificate] }
    end
    
    ##
    # Returns the certificate for the given GeoCerts::Order
    # 
    # === Exceptions
    # 
    # This method will raise exceptions if the given +order_id+ cannot be found in the GeoCerts
    # system.
    # 
    def self.find(order_id)
      order_id = order_id.id if order_id.kind_of?(GeoCerts::Order)
      new(call_api { GeoCerts.api.find_certificate(:order_id => order_id)[:certificate] })
    end
    
    ##
    # Returns the certificate for the given GeoCerts::Order by ID.
    # 
    # If the +order_id+ cannot be found in the GeoCerts system, this method will return +nil+.
    # 
    def self.find_by_order_id(order_id)
      find(order_id)
    rescue GeoCerts::AllowableExceptionWithResponse
      nil
    end
    
    
    ##
    # Reissues the certificate given a proper CSR.
    # 
    def reissue!(csr)
      csr = csr.body if csr.kind_of?(GeoCerts::CSR)
      update_attributes(self.class.call_api {
        GeoCerts.api.reissue_certificate({
          :order_id => self.order_id,
          :csr_body => GeoCerts.escape(csr || '')
        })
      })
    end

    def ca_intermediates=(input) #:nodoc:
      @ca_intermediates = input[:ca_intermediate].to_a
    end
    
  end
  
end
