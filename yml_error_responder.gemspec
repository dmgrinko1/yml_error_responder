$:.push File.expand_path("../lib", __FILE__)

require "yml_error_responder/version"

Gem::Specification.new do |s|
  s.name        = "yml_error_responder"
  s.version     = YmlErrorResponder::VERSION
  s.authors     = ["Egench"]
  s.email       = ["egnech@gmail.com"]
  s.summary     = "This gem let you simplify error responding."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 6.1", ">= 6.1.4.4"
end
