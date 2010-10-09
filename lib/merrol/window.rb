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

    signal_connect('destroy') do
      save_state
      false
    end

    view = Gtk::SourceView.new
    view.name = 'view'
    load_files(filepaths, view)
    add(view)

    show_all
  end

  def quit
    destroy
  end

  def save_state
    Gtk.main_quit
  end

  def load_files filepaths, view
    view.buffer.text = File.read(filepaths.first) if filepaths.first
  end
end

