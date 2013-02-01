require 'base64'
$LOAD_PATH << 'lib'
require 'merrol/version.rb'

Gem::Specification.new do |s|
  s.name        = 'merrol'
  s.version     = Merrol::VERSION
  s.authors     = 'Phil Thompson'
  s.email       = Base64.decode64("cGhpbEBlbGVjdHJpY3Zpc2lvbnMuY29t\n")
  s.homepage    = 'http://merrol.com'
  s.summary     = 'Merrol - Minimalist Editor for Ruby, Rails and Other Languages'
  s.description = 'Ruby and Rails editor with a focus on Test/Behaviour Driven Development'
  s.required_rubygems_version = '>= 1.3.6'

  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-minitest'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'rb-inotify', '~> 0.8.8'

  s.files              = `git ls-files`.split("\n")
  s.test_files         = `git ls-files -- spec/*`.split("\n")

  s.executables  = ['mer']
  s.require_path = 'lib'
end

