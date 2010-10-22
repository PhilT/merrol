require 'spec_helper'

describe Controller do
  it 'gets the name without controller suffix' do
    mock_view = mock Gtk::Window, :signal_connect => nil
    MainController.new(mock(Commands, :register => nil), {:main => mock_view}).name.should == :main
  end

  it 'access views using <name>_view method' do
    mock_view = mock Gtk::Window, :signal_connect => nil
    controller = Controller.new(mock(Commands, :register => nil), {:main => mock_view})
    controller.main_view.should == mock_view
  end

  it 'raises method missing error when view not found' do
    mock_view = mock Gtk::Window, :signal_connect => nil
    controller = Controller.new(mock(Commands, :register => nil), {:main => mock_view})
    lambda {controller.non_existent_view}.should raise_error NoMethodError
  end

  it 'raises method missing error when not a view method' do
    mock_view = mock Gtk::Window, :signal_connect => nil
    controller = Controller.new(mock(Commands, :register => nil), {:main => mock_view})
    lambda {controller.non_existent_method}.should raise_error NoMethodError
  end
end

