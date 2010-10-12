require 'spec_helper'

describe Gtk::Bin do
  it 'adds the container to the widget' do
    widget = Gtk::Window.new
    widget.container = 'VBox'
    widget.container.should be_a Gtk::VBox
    widget.children.first.should == widget.container
  end
end

