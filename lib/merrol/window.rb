class Window < Gtk::Window
  def initialize(title)
    super(title)
    set_default_size(800, 600)
    signal_connect('destroy') do
      save_state
      Gtk.main_quit
    end
    show_all
  end

  def save_state

  end
end

