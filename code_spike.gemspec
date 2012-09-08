# -*- encoding: utf-8 -*-
require File.expand_path('../lib/code_spike/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Sean Behan"]
  gem.email         = ["inbox@seanbehan.com"]
  gem.description   = %q{Down and dirty code spiking.}
  gem.summary       = %q{Spike code for ActiveRecord without a lot of setup code.}
  gem.homepage      = "http://github.com/gristmill"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "code_spike"
  gem.require_paths = ["lib"]
  gem.version       = CodeSpike::VERSION

  gem.add_dependency "activesupport", "~> 3.2"
  gem.add_dependency "activerecord", "~> 3.2"
end
