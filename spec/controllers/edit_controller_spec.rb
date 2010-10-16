require 'spec_helper'

describe EditController do
  before(:each) do
    @mock_commands = mock Commands, :register => nil
    @mock_view = mock(Gtk::SourceView)
    @edit = EditController.new(@mock_commands, {:edit => @mock_view})
  end

  it 'selects all text' do
    @mock_view.should_receive(:select_all).with true
    @edit.select_all
  end

  it 'deselects all text' do
    @mock_view.should_receive(:select_all).with false
    @edit.select_none
  end

  it 'undoes the last character(s) entered' do
    @mock_view.should_receive(:redo)
    @edit.redo
  end

  it 'redoes enters the last characters that were undone' do
    @mock_view.should_receive(:undo)
    @edit.undo
  end
end

