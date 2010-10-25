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

def some_text_in filename
  "some text in #{filename}"
end

