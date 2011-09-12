# Encoding: UTF-8
require 'rubygems'
require 'rake'

require File.expand_path('../lib/nataime/version', __FILE__)

Gem::Specification.new do |s|
  s.name = "nataime"
  s.version = Nataime::Version::STRING
  s.platform = Gem::Platform::RUBY
  s.author = "nettsundere"
  s.email = "nettsundere@gmail.com"
  s.homepage = "https://github.com/nettsundere/nataime"
  s.summary = "#{Configured::Version::SUMMARY}"
  s.description = "nataime. Poems about nata"
  s.files = Dir["{lib/*,lib/*/*,spec/*}"] + %w{README.md}
end
