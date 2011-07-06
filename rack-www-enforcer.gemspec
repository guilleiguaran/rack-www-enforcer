# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rack/www-enforcer/version"

Gem::Specification.new do |s|
  s.name        = "rack-www-enforcer"
  s.version     = Rack::WwwEnforcer::VERSION
  s.authors     = ["Guillermo Iguaran"]
  s.email       = ["guilleiguaran@gmail.com"]
  s.homepage    = "https://github.com/guilleiguaran/rack-www-enforcer"
  s.summary     = %q{Redirect requests to a subdomain in your app}
  s.description = <<-EOS
    Rack middleware to redirect requests to an specific subdomain in your app.
  EOS

  s.add_dependency 'rack'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
