module Merrol
  class Window < Gtk::Window
    include CommandDispatcher


    def initialize(title, filepaths)
      super(title)
      load_commands

      set_default_size(800, 600)
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


      view = SourceView.new
      load_files(filepaths, view.gtk)


      vbox.pack_start(statusbar, false, true, 1)
      view.add_to vbox
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

