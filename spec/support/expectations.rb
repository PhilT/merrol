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

def highlights item, options = {}
  widget = find_widget(options[:in] || options[:into], options[:test_against])
  widget.selection.selected[0].should == item
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

