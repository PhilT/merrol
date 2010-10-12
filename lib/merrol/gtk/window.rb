module Gtk
  class Window
    attr_reader :container

    def icon= path
      super File.app_relative(path)
    end

    def container= widget
      @container = eval(widget).new
      self.add(@container)
    end
  end
end

