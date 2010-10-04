# Like a single pass through Gtk.main but does not block allowing tests to finish
def process_events
  while Gtk.events_pending?
    Gtk.main_iteration
  end
end

# e.g. find_widget :named => 'something'
def find_widget name
  widget = Gtk::Window.toplevels.first
  name.split('.').each do |name|
    widget = widget.children.select{|child| child.name == name}.first
  end
  widget
rescue
  puts "Cannot find widget: #{options[:named]}. Failed on children of #{name}"
end

# ACTIONS

# e.g. pressing 'CTRL+S'
def pressing key, options = {}
  key = 'Return' if key == 'ENTER'
  widget = options[:in] || Gtk::Window.toplevels.first
  event = Gdk::EventKey.new(Gdk::Event::KEY_PRESS)
  event.window = widget
  event.state |= Gdk::Window::CONTROL_MASK if key =~ /CTRL+/
  event.state |= Gdk::Window::MOD1_MASK if key =~ /ALT+/
  event.state |= Gdk::Window::SHIFT_MASK if key =~ /SHIFT+/
  event.keyval = Gdk::Keyval.from_name(key.split('+').last)
  widget.grab_focus
  event.send_event = true
  entry = Gdk::Keymap.default.get_entries_for_keyval(event.keyval).first
  event.hardware_keycode = entry[0]
  widget.signal_emit('key_press_event', event)
end

# e.g. entering 'the_file', :into => 'open.search_field'
def entering text, options = {}
  widget = find_widget options[:into]
  widget.insert_text text, widget.position
end

# EXPECTATIONS

# e.g. shows 'open'
def shows widget_name
  find_widget(widget_name).should be_visible
end

# e.g. displays 'the_file', :in => 'open.results'
def displays text, options = {}
  options[:in].text.should == text
end

# e.g. loads :into => 'editor'
def loads contents, options = {}
  displays contents, :in => options[:into]
end

# e.g. saves the_contents, :in => 'the_file'
def saves contents, file
  File.read(file).should == contents
end

# e.g. quits
def quits

end

