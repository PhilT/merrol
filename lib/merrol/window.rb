module Merrol
  class Window < Gtk::Window
    include CommandDispatcher


    def initialize(title, filepaths)
      super(title)
      load_commands

      set_default_size(800, 600)
      self.icon = File.app_relative('data/merrol.svg')

      signal_connect('key_press_event') do |w, e|
        keys = []
        keys << "CTRL" if e.state.control_mask?
        keys << "ALT" if e.state.mod1_mask?
        keys << "SHIFT" if e.state.shift_mask?
        unmodified_keyval = Gdk::Keymap.default.lookup_key(e.hardware_keycode, 0, 0)
        keys << Gdk::Keyval.to_name(unmodified_keyval).upcase
        shortcut = keys.join('+')
        handle(shortcut)
        false
      end

  #    @editors = EditorController.new
  #    signal_connect('delete_event') do
  #      @buffers.modified.any? ? panel.warning :modified; true : false
  #    end

      signal_connect('destroy') do
        save_state
        false
      end

      vbox = Gtk::VBox.new

      statusbar = Gtk::HBox.new
      @fileinfo = Gtk::Label.new
      statusbar.pack_start(@fileinfo, false, false)

      editor_yaml = YAML.load(File.open(File.join(File.dirname(__FILE__), "views/editor.yml")))['editor']
      view = nil
      editor_yaml.each do |key, value|
        if key == 'type'
          view = eval('Gtk::' + value).new
        elsif value.is_a?(Hash)
          view.send("#{key}=", eval("Gtk::#{value['type']}::#{value['value']}"))
        elsif key == 'add_to'
          #not implemented
        else
          view.send("#{key}=", value)
        end
      end

      load_files(filepaths, view)

      vbox.pack_start(statusbar, false, true, 1)
      vbox.pack_start(view, true, true, 1)
      add(vbox)

      show_all
    end

    def complete

    end

    def quit
      destroy
    end

    def save_state
      Gtk.main_quit
    end

    def load_files filepaths, view
      if filepaths.first
        view.buffer.text = File.read(filepaths.first)
        @fileinfo.text = filepaths.first
      end
    end
  end
end

