module Gtk
  class Widget
    def font= font
      self.modify_font(Pango::FontDescription.new(font))
    end
  end
end

