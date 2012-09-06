require "rack"
require "rack/request"

module Rack
  class WwwEnforcer

    def initialize(app, options = {})
      @app = app
      @subdomain = options[:subdomain] || "www"
      @replace_subdomain = options[:replace_subdomain]
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
      unless @replace_subdomain
        url.host  = "#{@subdomain}.#{url.host}"
      else
        url.host = url.host.gsub(/^([^.]+)(\..*)$/, "#{@subdomain}#{'\2'}")
      end
      headers   = {'Content-Type' => 'text/html', 'Location' => url.to_s}

      [301, headers, []]
    end
  end
end
