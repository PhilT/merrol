require 'rake/testtask'
require './lib/merrol/version.rb'

task :default => :all
task :all => [:unit, :functional, :integration]

Rake::TestTask.new(:unit) do |t|
  t.ruby_opts << '-r./spec/spec_helper'
  t.libs << 'spec'
  t.test_files = FileList['spec/unit/**/*_spec.rb']
end

Rake::TestTask.new(:functional) do |t|
  t.ruby_opts << '-r./spec/spec_helper'
  t.libs << 'spec'
  t.test_files = FileList['spec/functional/**/*_spec.rb']
end

Rake::TestTask.new(:integration) do |t|
  t.ruby_opts << '-r./spec/integration_helper'
  t.libs << 'spec'
  t.test_files = FileList['spec/integration/**/*_spec.rb']
end

task :run do |t|
  system 'ruby -Ilib bin/mer'
end

def gemspec_path
  Dir['*.gemspec'].first
end

def gem_path
  "merrol-#{Merrol::VERSION}.gem"
end

desc 'Build and install the gem'
task :install do
  result = `gem build #{gemspec_path} 2>&1`
  if result =~ /Successfully built/
    system "gem uninstall -x merrol 2>&1"
    system "gem install #{gem_path} --no-rdoc --no-ri 2>&1"
  else
    raise result
  end
end

desc 'Creates a git tag of gem version and sends the gem to rubygems'
task :release do
  system "git tag -f -a v#{Merrol::VERSION} -m 'Version #{Merrol::VERSION}'"
  system "git push --tags"
  system "gem push #{gem_path}"
end

