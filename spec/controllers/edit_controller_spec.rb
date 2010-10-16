require 'spec_helper'

describe EditController do
  before(:each) do
    @mock_commands = mock Commands, :register => nil
    @mock_views = {:edit => mock(Gtk::SourceView)}
  end

  it 'creates the source models' do
    mock_source_model = mock SourceModel
    SourceModel.should_receive(:new).with('path1').and_return mock_source_model
    SourceModel.should_receive(:new).with('path2').and_return mock_source_model
    edit = EditController.new @mock_commands, @mock_views
    @mock_views[:edit].should_receive(:buffer=).once.with mock_source_model
    edit.load_all ['path1', 'path2']
  end
end

