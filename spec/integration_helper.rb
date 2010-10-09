require 'spec_helper' unless defined?(APP_NAME)

# Like a single pass through Gtk.main but does not block allowing tests to finish
def process_events
  while Gtk.events_pending?
    Gtk.main_iteration
  end
end

# e.g. find_widget :named => 'something'
def find_widget path
  widget = Gtk::Window.toplevels.first
  path.split('.').each do |name|
    widget = widget.children.select{|child| child.name == name}.first
    raise "Cannot find widget: #{path}" unless widget
  end
  widget
rescue name = ''
  raise "Cannot find widget: #{path}. Failed on children of #{name}"
end

# ACTIONS

# e.g. create_file 'the_file', :containing => @the_contents
def create_file name, options
  File.open(name, "w") do |f|
    f.print options[:containing]
  end
end

def destroy_file name
  File.delete(name)
end

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
  process_events
end

# EXPECTATIONS

# e.g. shows 'open'
def shows widget_name
  find_widget(widget_name).should be_visible
end

# e.g. displays 'the_file', :in => 'open.results'
def displays text, options = {}
  widget = find_widget(options[:in])
  buffer = widget.is_a?(Gtk::TextView) ? widget.buffer : widget
  buffer.text.should == text
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
def quits_by_pressing key
  Gtk.should_receive(:main_quit)
  pressing key
  process_events
end

