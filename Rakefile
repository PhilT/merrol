desc 'runs the specs'
task :spec do
  system 'rspec spec'
end

desc 'builds the gem'
task :build do
  system 'gem build merrol.gemspec'
end

desc 'installs the gem'
task :install do
  system 'gem install merrol-0.0.0.gem'
end

desc 'build, install and run the gem'
task :run do
  system "mer"
end

task :default => [:spec, :build, :install, :run]

