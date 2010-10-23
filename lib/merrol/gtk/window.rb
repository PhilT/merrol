module Gtk
  class Window
    def icon= path
      set_icon File.app_relative(path)
    end

    def default_position= coords
      coords = coords.split(',')
      move coords[0].to_i, coords[1].to_i
    end

    def default_size= size
      size = size.split(',')
      set_default_size size[0].to_i, size[1].to_i
    end
  end
end

