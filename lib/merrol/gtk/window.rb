module Gtk
  class Window
    def icon= path
      set_icon File.app_relative(path)
    end
  end
end

