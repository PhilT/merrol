require 'spec_helper'

describe Controller do
  it 'gets the name without controller suffix' do
    mock_view = mock Gtk::Window, :signal_connect => nil
    MainController.new(mock(Commands, :register => nil), {:main => mock_view }).name.should == :main
  end
end

