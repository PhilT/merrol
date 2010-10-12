module Gtk
  class Window
    def icon= path
      set_icon File.app_relative(path)
    end

    def container= widget
      @container = eval(widget).new
      self.add(@container)
    end
  end
end

