$:.push File.expand_path("../../lib", __FILE__)
require 'rack-www-enforcer'

require 'test/unit'
require 'rack/test'

class TestWwwEnforcer < Test::Unit::TestCase
  include Rack::Test::Methods

  def mock_app
    lambda { |env|
      headers = {'Content-Type' => "text/html"}
      [200, headers, ["OK"]]
    }
  end

  def app
    @app ||= Rack::WwwEnforcer.new(mock_app)
  end
  attr_writer :app

  def test_redirect_to_default_subdomain
    get "http://example.org/"
    assert_equal "http://www.example.org/",
      last_response.headers['Location']
  end

  def test_redirect_to_custom_subdomain
    old_app = self.app
    self.app = Rack::WwwEnforcer.new(mock_app, :subdomain => "app")
    get "http://example.org/"
    assert_equal "http://app.example.org/",
      last_response.headers['Location']
  ensure
    self.app = old_app
  end

  def test_redirect_if_subdomain_already_given_and_replacing_subdomain
    old_app = self.app
    self.app = Rack::WwwEnforcer.new(mock_app, :subdomain => "app", :replace_subdomain => true)
    get "http://www.example.org"
    assert_equal "http://app.example.org/",
      last_response.headers['Location']
  ensure
    self.app = old_app
  end
end
