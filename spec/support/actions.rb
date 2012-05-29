def starting_application
  $closing = true
  Merrol::Application.new Gooy::Window.new 'merrol'
  process_events
end

def quit_application
  Gtk::Window.toplevels.first.destroy
  process_events
end

def pressing key, options = {}
  widget = find_widget(options[:in])
  widget.grab_focus

  event = Gooy::Shortcut.to_event(key)
  keycode, group, level = Gdk::Keymap.default.get_entries_for_keyval(event.keyval).first
  event.hardware_keycode = keycode
  widget.signal_emit('key_press_event', event)
  process_events
end

def releasing key, options = {}
  widget = find_widget(options[:in])
  event = Gooy::Shortcut.to_event(key, :release)
  keycode, group, level = Gdk::Keymap.default.get_entries_for_keyval(event.keyval).first
  event.hardware_keycode = keycode
  widget.signal_emit('key_release_event', event)
  process_events
end

def entering text, options
  widget = find_widget options[:into]
  widget.insert_text text, widget.position
  process_events
end

