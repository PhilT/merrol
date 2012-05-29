module Gooy
  class TextView < Widget
    @@manager = Gtk::SourceStyleSchemeManager.new

    def initialize name
      super Gtk::SourceView.new, name
    end

    def theme_path path
      @@manager.prepend_search_path(path)
    end

    def theme id
      object.buffer.style_scheme = @@manager.get_scheme(id)
    end
  end
end

