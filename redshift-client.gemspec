lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redshift/client/version'

Gem::Specification.new do |spec|
  spec.name          = "redshift-client"
  spec.version       = Redshift::Client::VERSION
  spec.authors       = ["Dai Akatsuka"]
  spec.email         = ["d.akatsuka@gmail.com"]

  spec.summary       = %q{The ruby client for AWS Redshift.}
  spec.description   = %q{This gem provides a way to connect to AWS Redshift using the ruby-pg.}
  spec.homepage      = "https://github.com/dakatsuka/redshift-client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "pg"
  spec.add_runtime_dependency "activesupport", ">= 4"

  spec.add_development_dependency "bundler", "~> 2.4"
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
