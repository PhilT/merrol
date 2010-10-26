# e.g. pressing 'CTRL+S'
def pressing key, options = {}
  widget = options[:in] || find_widget(:main, options[:test_against])
  widget.grab_focus

  event = Shortcut.to_event(key)
  keycode, group, level = Gdk::Keymap.default.get_entries_for_keyval(event.keyval).first
  event.hardware_keycode = keycode
  widget.signal_emit('key_press_event', event)
  process_events
end

def releasing key, options = {}
  widget = options[:in] || find_widget(:main, options[:test_against])
  event = Shortcut.to_event(key, :release)
  keycode, group, level = Gdk::Keymap.default.get_entries_for_keyval(event.keyval).first
  event.hardware_keycode = keycode
  widget.signal_emit('key_release_event', event)
  process_events
end

# e.g. entering 'the_file', :into => 'open.search_field'
def entering text, options = {}
  widget = find_widget options[:into]
  widget.insert_text text, widget.position
  process_events
end

