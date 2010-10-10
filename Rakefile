desc 'runs the specs'
task :spec do
  system 'rspec spec'
end

desc 'builds the gem'
task :build do
  system 'gem build merrol.gemspec'
end

desc 'builds and installs the gem'
task :install => :build do
  system 'gem install merrol-0.0.0.gem'
end

desc 'run local app'
task :run do
  require_relative 'lib/merrol'
  Window.new(WORKING_DIR, [])
  Gtk.main
end

desc 'runs gem version of app'
task :mer do
  system 'mer'
end

desc 'tests, builds, installs and runs the app'
task :default => [:spec, :build, :install, :mer]

