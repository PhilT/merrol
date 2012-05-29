def process_events
  Gtk.main_iteration while Gtk.events_pending?
end

def find_widget path, start_at = Gtk::Window.toplevels.first
  return start_at if path.nil? || path == 'merrol'
  return unless start_at.respond_to?(:each)
  start_at.each do |child|
    return child if Regexp.new(path).match(child.path[0])
    find_widget path, child
  end
  raise "Cannot find widget: #{path}."
end

