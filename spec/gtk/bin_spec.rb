require 'spec_helper'

describe Gtk::Bin do
  it 'adds the container to the widget' do
    widget = Gtk::Window.new

    mock_vbox = mock Gtk::VBox
    Gtk::VBox.stub!(:new).and_return mock_vbox
    widget.should_receive(:add).with(mock_vbox)
    widget.container = 'VBox'
  end
end

