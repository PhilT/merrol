class Window < Gtk::Window
  def initialize(title)
    super(title)
    set_default_size(800, 600)
    signal_connect('key_press_event') do |w, e|
      keys = []
      keys << "CTRL" if e.state.control_mask?
      keys << "ALT" if e.state.mod1_mask?
      keys << "SHIFT" if e.state.shift_mask?
      unmodified_keyval = Gdk::Keymap.default.lookup_key(e.hardware_keycode, 0, 0)
      keys << Gdk::Keyval.to_name(unmodified_keyval).upcase
      shortcut = keys.join('+')
      destroy if shortcut == 'CTRL+Q'
      false
    end

    signal_connect('destroy') do
      save_state
      Gtk.main_quit
    end
    show_all
  end

  def save_state

  end
end

