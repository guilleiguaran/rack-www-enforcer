module Rack
  module WwwEnforcer

    def initialize(app, options = {})
      @app = app
      @subdomain = options[:subdomain]
    end

    def call(env)
      @app.call(env)
    end
  end
end
