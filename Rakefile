desc 'runs the specs'
task :spec do
  system 'rspec spec'
end

desc 'builds the gem'
task :build do
  raise 'Unable to build gem' unless system 'gem build merrol.gemspec'
end

desc 'builds and installs the gem'
task :install => :build do
  raise 'Unable to install gem' unless system 'gem install merrol-0.0.0.gem'
end

desc 'run local app. Loads application.rb by default. Override with f='
task :run do
  require_relative 'lib/merrol'
  module Merrol
    Application.start_in WORKING_DIR, [ENV['f'] || 'lib/merrol/application.rb']
    Gtk.main
  end
end

desc 'tests, builds, installs and runs the app'
task :default => [:spec, :build, :install] do
  system 'm'
end

