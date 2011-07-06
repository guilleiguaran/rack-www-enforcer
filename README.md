Rack::WwwEnforcer
=================

Rack Middleware for redirect requests to an specific subdomain of your app. (Ex. http://mysite.com to https://app.mysite.com)

Usage
-------

    use Rack::WwwEnforcer, :subdomain => "app"

If subdomain isn't present "www" is used by default.

You can use it in your Rails app, in the environment configuration file add it to Middleware stack:

    config.middleware.insert_before ActionDispatch::Static, Rack::WwwEnforcer