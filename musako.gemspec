# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'musako/version'

Gem::Specification.new do |spec|
  spec.name          = "musako"
  spec.version       = Musako::VERSION
  spec.authors       = ["yo_waka"]
  spec.email         = ["y.wakahara@gmail.com"]
  spec.summary       = %q{A simple static site generator}
  spec.homepage      = "https://github.com/waka/musako"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "slim"
  spec.add_runtime_dependency "redcarpet"
  spec.add_runtime_dependency "pygments.rb"
  spec.add_runtime_dependency "builder"
  spec.add_runtime_dependency "sass"
  spec.add_runtime_dependency "commander"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
