module Merrol
  class SourceView
    attr_reader :gtk
    SMART_HOME_END = {:before => 1, :after => 2, :both => 3}

    def initialize
      view = Gtk::SourceView.new
      view.auto_indent = true
      view.highlight_current_line = true
      view.indent_on_tab = true
      view.insert_spaces_instead_of_tabs = true
      view.show_line_numbers = true
      view.wrap_mode = Gtk::TextTag::WRAP_WORD
      view.smart_home_end = SMART_HOME_END[:before]
      view.buffer.language = Gtk::SourceLanguageManager.new.get_language 'rubyonrails'
      view.modify_font(Pango::FontDescription.new("monospace 9"))
      scheme = Gtk::SourceStyleSchemeManager.new.prepend_search_path('/home/phil/.gnome2/gedit/styles').get_scheme('railscasts')
      view.buffer.style_scheme = scheme
      view.tab_width = 2
      view.name = 'view'

      @scrollbars = Gtk::ScrolledWindow.new
      @scrollbars.set_policy(Gtk::POLICY_AUTOMATIC, Gtk::POLICY_AUTOMATIC)
      @scrollbars.add(view)
      @gtk = view
    end

    def add_to widget
      widget.pack_start @scrollbars, true, true, 1
    end
  end
end

