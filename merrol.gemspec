require 'base64'
$LOAD_PATH << 'lib'
require 'merrol/version.rb'

@dependencies = []
@development_dependencies = []

def self.source url
end

def self.gem name
  if [:test, :development].include? @group
    @development_dependencies << name
  else
    @dependencies << name
  end
end

def self.group name, &block
  @group = name
  yield
  @group = nil
end

eval File.read('Gemfile')

Gem::Specification.new do |s|
  s.name        = 'merrol'
  s.version     = Merrol::VERSION
  s.authors     = 'Phil Thompson'
  s.email       = Base64.decode64("cGhpbEBlbGVjdHJpY3Zpc2lvbnMuY29t\n")
  s.homepage    = 'http://merrol.com'
  s.summary     = 'Merrol - Minimalist Editor for Ruby, Rails and Other Languages'
  s.description = 'Ruby and Rails editor with a focus on Test/Behaviour Driven Development'
  s.required_rubygems_version = '>= 1.3.6'

  @dependencies.each do |name|
    s.add_dependency name
  end

  @development_dependencies.each do |gem|
    s.add_development_dependency name
  end

  s.files              = `git ls-files`.split("\n")
  s.test_files         = `git ls-files -- spec/*`.split("\n")

  s.executables  = ['m']
  s.require_path = 'lib'
end

