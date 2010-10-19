require 'spec_helper'

Rspec.configure do |c|
  c.before(:all) do
    # Stops the windows being shown which raises Gtk/Gdk errors when emitting key events and also interupts the display
    class Gtk::Window
      def show_all
      end
    end

    #Cannot quit GTK as we're not starting the main loop
    module Gtk
      def self.main_quit
      end
    end

    @application = Application.start_in WORKING_DIR, [] unless @application
  end
end

# Like a single pass through Gtk.main but does not block allowing tests to finish
def process_events
  while Gtk.events_pending?
    Gtk.main_iteration
  end
end

# e.g. find_widget :named => 'something'
def find_widget name
  widget = @application.widgets[name]
  raise "Cannot find widget: #{name}." unless widget
  widget
end

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
  widget = options[:in] || Gtk::Window.toplevels.first
  widget.grab_focus

  event = Shortcut.to_event(key)
# TODO: Remove if not needed once running integration tests again
#  event.window = widget
#  event.send_event = true
#  keycode, group, level = Gdk::Keymap.default.get_entries_for_keyval(event.keyval).first
#  event.hardware_keycode = keycode
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
  @application.should_receive(:quit)
  pressing key, :in => find_widget('main')
  process_events
end

