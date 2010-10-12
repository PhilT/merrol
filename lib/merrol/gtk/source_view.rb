module Gtk
  class SourceView
    def language= name
      self.buffer.language = SourceLanguageManager.new.get_language name
    end

    def font= font
      self.modify_font(Pango::FontDescription.new(font))
    end

    def theme= path
      name = File.basename(path)
      path = path[0..-name.length - 2]
      manager = SourceStyleSchemeManager.new
      manager.prepend_search_path(File.app_relative(path))
      scheme = manager.get_scheme(name.downcase)
      self.buffer.style_scheme = scheme
    end
  end
end

