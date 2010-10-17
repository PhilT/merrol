module Gtk
  class SourceView
    attr_reader :theme, :highlight_brackets

    def theme= path
      name = File.basename(path)
      path = path[0..-name.length - 2]
      manager = SourceStyleSchemeManager.new
      manager.prepend_search_path(File.app_relative(path))
      @theme = manager.get_scheme(name.downcase)
    end

    def highlight_matching_brackets= on
      @highlight_brackets = on
    end
  end
end

