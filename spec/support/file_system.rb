require 'fakefs'

def project_root
  'tmp/project'
end

def project_root_paths
  %w(README.md lib)
end

def create path, content = ''
  FileUtils.mkdir_p File.dirname(path)
  File.open(path, 'w') {|f| f.puts content }
end

FileUtils.mkdir_p project_root
FileUtils.chdir project_root
create 'README.md'
create 'lib/app.rb'
create 'lib/models/post.rb'
create 'lib/models/category.rb'

class MiniTest::Unit
  alias :original_run_suites :_run_suites
  def _run_suites(suites, type)
    begin
      FakeFS.activate!
      original_run_suites(suites, type)
    ensure
      FakeFS.deactivate!
    end
  end
end

