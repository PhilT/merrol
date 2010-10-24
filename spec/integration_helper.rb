require 'spec_helper'

Rspec.configure do |c|
  c.before(:all) do
    module Gtk
      def self.main_quit
      end
    end

    unless $application
      puts 'Starting new app...'
      $application = Application.new WORKING_DIR, ['README.md']
    end
  end
end

# Like a single pass through Gtk.main but does not block allowing tests to finish
def process_events
  while Gtk.events_pending?
    Gtk.main_iteration
  end
end

def show_ui
  Gtk.main
end

# e.g. find_widget :named => 'something'
def find_widget name, application = nil
  widget = (application || $application).views[name]
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

# e.g. displays 'the_file', :in => 'open.results'
def displays text, options = {}
  widget = find_widget(options[:in] || options[:into], options[:test_against])
  buffer = widget.is_a?(Gtk::TextView) ? widget.buffer : widget
  buffer.text.should == text
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

