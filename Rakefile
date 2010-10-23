desc 'runs the specs (except integration)'
task :spec do
  specs = (Dir['spec/*/'] - ['spec/integration/']).join(' ')
  coverage = 'export COVERAGE=true && ' if ENV['COVERAGE']
  raise 'FAILED: Specs' unless system "#{coverage}rspec #{specs}"
end

desc 'runs integration specs'
task :integration do
  raise 'FAILED: Integration' unless system 'rspec spec/integration'
end

desc 'builds the gem'
task :build do
  raise 'FAILED: Unable to build gem' unless system 'gem build merrol.gemspec'
end

desc 'builds and installs the gem'
task :install => :build do
  raise 'FAILED: Unable to install gem' unless system 'gem install merrol-0.0.0.gem'
end

desc 'run local app. Loads application.rb by default. Override with f=file,file,file'
task :run do
  require_relative 'lib/merrol'
  module Merrol
    Application.start_in WORKING_DIR, (ENV['f'] && ENV['f'].split(',')) || %w(lib/merrol/application.rb README.md)
    Gtk.main
  end
end

desc 'tests, builds, installs and runs the app'
task :default => [:spec, :integration, :build, :install] do
  system 'm'
end

desc 'code coverage'
task :coverage do
  ENV['COVERAGE'] = 'true'
  Rake::Task['spec'].invoke
end

desc 'takes the version in the gemspec creates a git tag and sends the gem to rubygems'
task :release do
  gemspec = File.read('merrol.gemspec')
  name = gemspec.scan(/s\.name.*=.*"(.*)"/).first.first
  version = gemspec.scan(/s\.version.*=.*"(.*)"/).first.first
  system "git tag -a v#{version} -m 'Version #{version}'"
  system "gem push #{name}-#{version}.gem"
end

