$LOAD_PATH << 'lib'
require 'merrol'
include Merrol

def to_event key
  event = Gdk::EventKey.new(Gdk::Event::KEY_PRESS)
  event.state |= Gdk::Window::CONTROL_MASK if key =~ /CTRL+/
  event.state |= Gdk::Window::MOD1_MASK if key =~ /ALT+/
  event.state |= Gdk::Window::SHIFT_MASK if key =~ /SHIFT+/
  event.keyval = Gdk::Keyval.from_name(key.split('+').last)
  entry = Gdk::Keymap.default.get_entries_for_keyval(event.keyval).first
  event.hardware_keycode = entry[0]
  event
end

