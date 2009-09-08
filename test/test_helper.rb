$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rubygems'

require 'geo_certs'

require 'test/unit'
require 'uri'
require 'shoulda'
require 'factory_girl'
require 'factories'
# require 'mocha'

# Load any initializers for testing.
Dir[File.dirname(__FILE__) + '/config/initializers/**/*.rb'].sort.each do |initializer|
  require initializer
end

class Test::Unit::TestCase
  
  def managed_server_request(method, url, options = {}, &block)
    uri           = URI.parse(url)
    uri.user      = GeoCerts.login
    uri.password  = GeoCerts.api_token
    
    unless use_remote_server?
      FakeWeb.register_uri(method, uri.to_s, options)
    end
    
    yield
  ensure
    FakeWeb.clean_registry
  end
  
  def exclusively_mocked_request(method, url, options = {}, &block)
    managed_server_request(method, url, options, &block) unless use_remote_server?
  end
  
  def assert_responds_with_exception(exception, *error_codes, &block)
    raised = false
    begin
      yield
      flunk "A #{exception} exception failed to be thrown"
    rescue exception => e
      return unless e.respond_to?(:errors)
      error_codes.each do |code|
        assert e.errors.any? { |error| error.code == code }, "No error was returned with Code #{code}\n#{e.errors.inspect}"
      end
    rescue Exception => e
      flunk "A #{e} exception was thrown, rather than the #{exception} exception expected"
    end
  end
  
end