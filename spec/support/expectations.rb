def hides widget_name
  find_widget(widget_name).wont_be :visible?
end

# shows 'text', :in => 'path.to.widget'
# shows 'path.to.widget'
# shows 'text', :for => :attribute, :in => 'path.to.widget'
# shows ['item', 'item', 'item'], :in => 'path.to.list.widget'
def shows text_or_name, options = {}
  if options[:in] || options[:into]
    widget = find_widget(options[:in] || options[:into])
    match_text widget, text_or_name, options[:for] || :text
  else
    find_widget(text_or_name).must_be :visible?
  end
end

def match_text widget, expected, attribute
  if widget.is_a?(Gtk::Image)
    text = widget.file
  elsif widget.is_a?(Gtk::TextView)
    text = widget.buffer.text
  elsif widget.is_a?(Gtk::TreeView)
    text = widget.model.inject([]) { |model, path, iter| text << iter[0] }.join(',')
    expected = expected.join(',')
  else
    text = widget.send(attribute)
  end
  text.must_match expected
end

# highlights 'selection', :in => 'path.to.widget'
def highlights item, options = {}
  widget = find_widget(options[:in])
  widget.selection.selected[0].must_equal item
end

def quits_application
  $closing.must_equal true
end

