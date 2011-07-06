$:.push File.expand_path("../lib", __FILE__)
require "www-enforcer"

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

end
