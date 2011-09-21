module Plugins
  module SearchReplace
    class Base
      EXTENSIONS = '{' + %w(Rakefile Gemfile Gemfile.lock Guardfile .gitignore .rspec .autotest *.md *.gemspec *.rb *.js *.erb).join(',') + '}'

      #desc 'Searches all files in project for the %regexp% and returns the files that matched'
      def self.search regexp
        found = []
        matches = 0
        Dir["**/#{EXTENSIONS}"].each do |file|
          content = File.read(file)
          matches += count = content.scan(regexp).size
          found << file if count > 0
        end
        [matches] + found
      end

      #desc 'Searches all files in project for the %regexp% and replaces with %replacement%.
      #Returns the files that were changed'
      def self.replace regexp, replacement
        changed = []
        Dir["**/#{EXTENSIONS}"].each do |file|
          content = File.read(file)
          new_content = content.gsub(regexp, replacement)
          if content != new_content
            File.write(file, new_content)
            changed << file
          end
        end
        changed
      end
    end
  end
end

