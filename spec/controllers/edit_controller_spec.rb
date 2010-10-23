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

  it 'calls redo on view' do
    @mock_view.should_receive(:redo)
    @edit.redo
  end

  it 'calls undo on view' do
    @mock_view.should_receive(:undo)
    @edit.undo
  end

  it 'calls delete on view' do
    @mock_buffer = mock SourceModel
    @mock_view.stub(:buffer).and_return @mock_buffer
    @mock_buffer.should_receive(:delete_selection).with(true, true)
    @edit.delete
  end

end

