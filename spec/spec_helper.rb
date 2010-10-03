RSpec.configure do |c|
  c.before(:all) do

  end

  c.before(:each) do
    while Gtk.events_pending?
      Gtk.main_iteration
    end
  end

  c.after(:each) do

  end

  c.after(:all) do

  end
end

# Emits a key event in the specified widget
# example:
#   press "CTRL+F", :in => widget
def press(key, options)
  event = Gdk::EventKey.new(Gdk::Event::KEY_PRESS)
  event.state |= Gdk::Window::CONTROL_MASK if key =~ /CTRL+/
  event.state |= Gdk::Window::MOD1_MASK if key =~ /ALT+/
  event.state |= Gdk::Window::SHIFT_MASK if key =~ /SHIFT+/
  event.keyval = Gdk::Keyval.from_name(key.split('+').last)
  event.hardware_keycode = Gdk::Keymap.default.get_entries_for_keyval(event.keyval).first.first
  options[:in].signal_emit('key_press_event', event)
end

