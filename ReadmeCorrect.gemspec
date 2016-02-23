# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'readme-correct/version'

Gem::Specification.new do |spec|
  spec.name          = ReadmeCorrect::PRODUCT
  spec.version       = ReadmeCorrect::VERSION
  spec.authors       = ["dkhamsing"]
  spec.email         = ["dkhamsing8@gmail.com"]

  spec.summary       = 'Correct READMEs'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/dkhamsing/correct-readme'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = [ReadmeCorrect::PRODUCT, ReadmeCorrect::BATCH]
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'github-readme', '~> 0.1.0.pre' # github
  spec.add_runtime_dependency 'netrc'   # credentials
  spec.add_runtime_dependency 'differ'  # string diff
end
