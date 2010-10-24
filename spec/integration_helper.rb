require 'spec_helper'

Rspec.configure do |c|
  c.before(:all) do
    module Gtk
      def self.main_quit
      end
    end

    $application = Application.new WORKING_DIR, [] unless $application
  end
end

def process_events
  while Gtk.events_pending?
    Gtk.main_iteration
  end
end

def find_widget name, application = nil
  widget = (application || $application).views[name]
  raise "Cannot find widget: #{name}." unless widget
  widget
end

def load_file name
  $application.controllers['file'].load name
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
  widget = options[:in] || find_widget(:main, options[:test_against])
  widget.grab_focus

  event = Shortcut.to_event(key)
# TODO: Remove if not needed once running integration tests again
  keycode, group, level = Gdk::Keymap.default.get_entries_for_keyval(event.keyval).first
  event.hardware_keycode = keycode
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

def does_not_show widget_name
  find_widget(widget_name).should_not be_visible
end

# e.g. displays 'the_file', :in => :edit
def displays expected, options = {}
  widget = find_widget(options[:in] || options[:into], options[:test_against])

  if widget.is_a?(Gtk::Image)
    text = widget.file
  elsif widget.is_a?(Gtk::TextView)
    text = widget.buffer.text
  elsif widget.is_a?(Gtk::ListView)
    text = []
    widget.model.each { |model, path, iter| text << iter[0] }
    text = text.join(',')
    expected = expected.join(',')
  else
    text = widget.text
  end
  text.should match expected
end

# e.g. loads :into => 'editor'
def loads contents, options = {}
  displays contents, options
end

# e.g. saves the_contents, :in => 'the_file'
def saves contents, file
  File.read(file).should == contents
end

# e.g. quits
def quits_by_pressing key
  $application.controllers['main'].should_receive(:quit)
  pressing key, :in => find_widget(:main)
  process_events
end

