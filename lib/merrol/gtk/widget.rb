module Gtk
  class Widget
    def font= font
      self.modify_font(Pango::FontDescription.new(font))
    end

    def initially_hidden= hidden
      self.no_show_all = hidden
    end
  end
end

