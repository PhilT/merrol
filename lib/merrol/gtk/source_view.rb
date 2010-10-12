module Gtk
  class SourceView
    def language= name
      self.buffer.language = Gtk::SourceLanguageManager.new.get_language name
    end

    def font= font
      self.modify_font(Pango::FontDescription.new(font))
    end

    def theme= path
      name = File.basename(path)
      path = path[0..-name.length - 2]
      scheme = Gtk::SourceStyleSchemeManager.new.prepend_search_path(File.app_relative(path)).get_scheme(name.downcase)
      self.buffer.style_scheme = scheme
    end
  end
end

