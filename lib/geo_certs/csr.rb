module GeoCerts
  
  ##
  # Wraps information required by or received from GeoCerts about a 
  # Certificate Signing Request (CSR).
  # 
  class CSR
    
    attr_accessor :body,
                  :common_name,
                  :city,
                  :state,
                  :country,
                  :organization,
                  :organizational_unit
    
    def initialize(attributes = {})
      attributes.each_pair do |name, value|
        send("#{name}=", value) if respond_to?(name)
      end
    end
    
  end
  
end
