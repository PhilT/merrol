Gem::Specification.new do |s|
  s.name        = "merrol"
  s.version     = "0.0.2"
  s.authors     = "Phil Thompson"
  s.email       = "phil@electricvisions.com"
  s.homepage    = "http://merrol.com"
  s.summary     = "MERROL - Minimalist Editor for Ruby, Rails and Other Languages"
  s.description = "An editor for Ruby, Rails and supporting langauges, written in pure Ruby with an open design to allow customization and improvement."
  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "merrol"

  s.add_dependency "i18n"
  s.add_dependency "activesupport"
  s.add_dependency "colored"

  s.add_development_dependency "autotest"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "rspec"
  s.add_development_dependency "gtksourceview2"

  s.files              = `git ls-files`.split("\n")
  s.test_files         = `git ls-files -- spec/*`.split("\n")

  s.executables  = ['m']
  s.require_path = 'lib'
end

