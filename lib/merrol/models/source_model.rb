module Merrol
  class SourceModel < Gtk::SourceBuffer

    def initialize path = nil
      super(nil)
      @path = path
      language_from_filetype
      load
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
            match_on = File.extname(@path)
          else
            match_on = File.basename(@path)
          end

          if pattern == match_on
            self.language = Gtk::SourceLanguageManager.new.get_language name
            return
          end
        end
      end
    end
  end
end

