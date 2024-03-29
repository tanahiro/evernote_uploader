# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'evernote_uploader/version'

Gem::Specification.new do |spec|
  spec.name          = "evernote_uploader"
  spec.version       = EvernoteUploader::VERSION
  spec.authors       = ["Hiroyuki Tanaka"]
  spec.email         = ["hryktnk@gmail.com"]
  spec.summary       = "Upload files to Evernote"
  #spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = "https://github.com/tanahiro/evernote_uploader.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "evernote-thrift", "~> 1.25"
  spec.add_dependency "mime-types", "~> 3.1"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest"
end
