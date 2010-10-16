module Merrol
  class SourceModel < Gtk::SourceBuffer

    def initialize path = nil
      super(nil)
      @path = path
      load
    end

    def save
      File.open(@path, 'w') {|f| f.write(self.text) }
    end

    def load
      if @path && File.exist?(@path)
        non_undoable_action { self.text = File.read(@path) }
      end
    end
  end
end

