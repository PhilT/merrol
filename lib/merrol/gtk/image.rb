module Gtk
  class Image
    def file= path
      set_file File.app_relative(path)
    end
  end
end

