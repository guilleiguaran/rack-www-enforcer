Rack::WwwRedirect
=================

Rack Middleware for redirect requests to an specific subdomain of your app. (Ex. http://mysite.com to https://app.mysite.com)

Usage
-------

    use Rack::WwwRedirect, :subdomain => "app"
