require 'rspec/core/rake_task'

desc 'tests, builds, installs and runs the app'
task :default => [:coverage, :integration, :install] do
  system 'm'
end

desc 'runs the specs (except integration)'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = [
    './spec/controllers/*_spec.rb',
    './spec/gtk/*_spec.rb',
    './spec/lib/*_spec.rb',
    './spec/models/*_spec.rb'
  ]
end

desc 'Generate code coverage'
task :coverage do
  ENV['COVERAGE'] = 'true'
  Rake::Task['spec'].invoke
end

desc 'runs integration specs'
RSpec::Core::RakeTask.new(:integration) do |t|
  t.pattern = './spec/integration/*_spec.rb'
end

desc 'run local app. Loads application.rb by default. Override with f=file,file,file'
task :run do
  require_relative 'lib/merrol'
  module Merrol
    files = %w(lib/merrol/lib/application.rb README.md lib/merrol/lib/widget_builder.rb)
    Application.new WORKING_DIR, (ENV['f'] && ENV['f'].split(',')) || files
    Gtk.main
  end
end

desc 'Build and install the gem'
task :install do
  gemspec_path = Dir['*.gemspec'].first
  spec = eval(File.read(gemspec_path))

  result = `gem build #{gemspec_path} 2>&1`
  if result =~ /Successfully built/
    system "gem uninstall -x #{spec.name} 2>&1"
    system "gem install #{spec.file_name} --no-rdoc --no-ri 2>&1"
  else
    raise result
  end
end

desc 'takes the version in the gemspec creates a git tag and sends the gem to rubygems'
task :release do
  gemspec_path = Dir['*.gemspec'].first
  spec = eval(File.read(gemspec_path))

  system "git tag -f -a v#{spec.version} -m 'Version #{spec.version}'"
  system "git push --tags"
  system "gem push #{spec.file_name}"
end

