desc 'runs the specs (except integration)'
task :spec do
  specs = (Dir['spec/*/'] - ['spec/integration/']).join(' ')
  raise 'FAILED: Specs' unless system 'rspec -c ' + specs
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
    Application.start_in WORKING_DIR, ENV['f'].split(',') || ['lib/merrol/application.rb']
    Gtk.main
  end
end

desc 'tests, builds, installs and runs the app'
task :default => [:spec, :integration, :build, :install] do
  system 'm'
end

