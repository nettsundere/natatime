# Encoding: UTF-8
require 'rubygems'

require File.expand_path('../lib/natatime/version', __FILE__)

Gem::Specification.new do |s|
  s.name = "natatime"
  s.version = Natatime::Version::STRING
  s.platform = Gem::Platform::RUBY
  s.author = "nettsundere"
  s.email = "nettsundere@gmail.com"
  s.homepage = "https://github.com/nettsundere/natatime"
  s.summary = "#{Natatime::Version::SUMMARY}"
  s.description = "natatime. Poems about nata"
  s.files = Dir["{lib/*,lib/*/*,spec/*}"] + %w{README.md}
  s.add_dependency("unicode", ">= 0.4.0")
  s.add_development_dependency "configured"
end
