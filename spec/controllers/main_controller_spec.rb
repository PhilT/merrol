require 'spec_helper'

describe MainController do
  it 'sets the title' do
    mock_commands = mock Commands, :register => nil
    mock_view = mock Gtk::Window, :signal_connect => nil
    mock_view.should_receive(:title=).with('project (working/dir)')
    main = MainController.new mock_commands, {:main => mock_view}
    main.working_dir = 'working/dir/project'
  end
end

