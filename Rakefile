task :spec do
  system 'rspec spec'
end

task :build => :spec do
  system 'gem build .gemspec'
end

task :install => :build do
  system 'gem install merrol-0.0.0.gem'
end

desc 'build, install and run the gem'
task :run => :install do
  system "mer"
end

