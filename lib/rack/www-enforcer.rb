require "rack"
require "rack/request"

module Rack
  class WwwEnforcer

    def initialize(app, options = {})
      @app = app
      @subdomain = options[:subdomain] || "www"
    end

    def call(env)
      req = Request.new(env)
      if subdomain_present?(req)
        @app.call(env)
      else
        redirect_to_subdomain(req)
      end
    end

    private

    def subdomain_present?(req)
      host = URI(req.url).host
      host.match(/^([^.]+)\..*$/)[1] == @subdomain
    end

    def redirect_to_subdomain(req)
      url       = URI(req.url)
      url.host  = "#{@subdomain}.#{url.host}"
      headers   = {'Content-Type' => 'text/html', 'Location' => url.to_s}

      [301, headers, []]
    end
  end
end
