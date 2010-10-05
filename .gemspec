# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = "merrol"
  s.version     = "0.0.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = "Phil Thompson"
  s.email       = "phil@electricvisions.com"
  s.homepage    = "http://merrol.com"
  s.summary     = "Minimalist Editor for Ruby, Rails and Other Languages"
  s.description = "An editor for Ruby, Rails and supporting langauges, written in Ruby with an open design to allow customization and improvement."
  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "merrol"

  s.add_development_dependency "rspec"

  s.files              = `git ls-files`.split("\n")
  s.test_files         = `git ls-files -- spec/*`.split("\n")

  s.executables  = ['mer']
  s.require_path = 'lib'
end

