module Merrol
  class SourceModel < Gtk::SourceBuffer

    def initialize path = nil
      super(nil)
      @path = path
      load
      language_from_filetype
    end

    def save
      File.open(@path, 'w') {|f| f.write(self.text) }
      self.modified = false
    end

    def load
      if @path && File.exist?(@path)
        begin_not_undoable_action { self.text = File.read(@path) }
        self.modified = false
      end
    end

    def language_from_filetype
      yaml = YAML.load_config('language')
      yaml.each do |name, hash|
        hash['pattern'].split(' ').each do |pattern|
          if pattern[0..0] == '.' && @path[0..0] != '.'
            name_or_ext = File.extname(@path)
          else
            name_or_ext = File.basename(@path)
          end

          bang_line = "#!/usr/bin/env #{hash['bang']}"
          file_exists = hash['exists'] ? File.exist?(hash['exists']) : true
          if (pattern == name_or_ext || self.text[0..(bang_line.length - 1)] == bang_line) && file_exists
            self.language = Gtk::SourceLanguageManager.new.get_language name
            return
          end
        end
      end
    end
  end
end

