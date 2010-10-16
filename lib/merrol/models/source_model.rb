module Merrol
  class SourceModel < Gtk::SourceBuffer

    def initialize path = nil
      super(nil)
      @path = path
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
  end
end

