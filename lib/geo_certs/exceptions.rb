require 'geo_certs/errors'

module GeoCerts
  
  HTTP_ERRORS = [ Timeout::Error,
                  Errno::EINVAL,
                  Errno::ECONNRESET,
                  EOFError,
                  Net::HTTPBadResponse,
                  Net::HTTPHeaderSyntaxError,
                  Net::ProtocolError ]
  
  ##
  # The lowest-level GeoCerts exception.  All exceptions raised from within this library 
  # should be inherited from this exception.
  # 
  class Exception < RuntimeError; end
  
  ##
  # An exception that is raised which contains an HTTP response, and additionally, errors
  # and warnings received from GeoCerts.
  # 
  class ExceptionWithResponse < Exception
    
    attr_reader :response
    
    def initialize(response = nil)
      if response.respond_to?(:response)
        self.response = response.response
      elsif response
        self.response = response
      end
      
      self.set_backtrace(response.backtrace) if response.respond_to?(:backtrace)
    end
    
    def http_code
      response ? response.code.to_i : nil
    end
    
    def errors
      @errors ||= []
    end
    
    def warnings
      @warnings ||= []
    end
    
    def response=(response) # :nodoc:
      @response = response
      
      if !response.respond_to?(:body)
        return @response
      elsif Hash.respond_to?(:from_xml)
        build_objects_for(Hash.from_xml(response.body))
      else
        build_objects_for(parse_errors(response.body))
      end
      
      @response
    end
    
    def to_s # :nodoc:
      "HTTP #{http_code}: A #{self.class.name} exception has occurred"
    end
    
    private
    
    
    def parse_errors(input)
      require 'geo_certs/hash_extension'
      Hash.from_libxml(input)
    end
    
    def build_objects_for(errors_and_warnings)
      [errors_and_warnings['errors']['error']].compact.flatten.each do |error|
        self.errors << GeoCerts::Error.new(:code => error['code'], :message => error['message'])
      end
      [errors_and_warnings['errors']['warning']].compact.flatten.each do |error|
        self.warnings << GeoCerts::Warning.new(:code => error['code'], :message => error['message'])
      end
    end
    
  end
  
  
  class Unauthorized        < ExceptionWithResponse # :nodoc:
  end
  
  class BadRequest          < ExceptionWithResponse # :nodoc:
  end
  
  class UnprocessableEntity < ExceptionWithResponse # :nodoc:
  end
  
  class ResourceNotFound    < ExceptionWithResponse # :nodoc:
  end
  
  class RequestFailed       < ExceptionWithResponse # :nodoc:
  end
  
  class RequestTimeout      < Exception # :nodoc:
  end
  
  class ConnectionError     < Exception # :nodoc:
  end
  
end
