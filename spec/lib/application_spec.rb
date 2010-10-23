require 'spec_helper'

describe Application do
  before(:each) do
    @mock_window = mock Gtk::Window, :show_all => nil
    @mock_file_list = mock Gtk::ListView, :list= => nil
    @mock_file_path = mock Gtk::Label, :text= => nil
    @mock_edit = mock Gtk::SourceView, :grab_focus => nil
    @mock_commands = mock Commands
    @mock_main = mock MainController, :working_dir= => nil
    @mock_file = mock FileController, :load_all => nil

    @widgets = {:main => @mock_window, :file_list => @mock_file_list, :file_path => @mock_file_path, :edit => @mock_edit}
    WidgetBuilder.stub(:build).and_return(@widgets)
    Commands.stub(:new).and_return @mock_commands
    Dir.stub(:[]).and_return %w(main_controller.rb file_controller.rb)
    MainController.stub(:new).and_return @mock_main
    FileController.stub(:new).and_return @mock_file
  end

  it 'builds widgets' do
    WidgetBuilder.should_receive :build
    Application.new nil, []
  end

  it 'creates controllers' do
    MainController.should_receive :new
    FileController.should_receive :new
    Application.new nil, []
  end

  it 'sets working dir' do
    @mock_main.should_receive(:working_dir=).with 'working dir'
    Application.new 'working dir', []
  end

  it 'loads files' do
    @mock_file.should_receive(:load_all).with ['paths']
    Application.new nil, ['paths']
  end

  it 'populates file list' do
    @mock_file_list.should_receive(:list=).with ['paths']
    Application.new nil, ['paths']
  end

  it 'sets file path' do
    @mock_file_path.should_receive(:text=).with 'path'
    Application.new nil, ['path']
  end

  it 'focuses source view' do
    @mock_edit.should_receive(:grab_focus)
    Application.new nil, []
  end

  it 'shows main window' do
    @mock_window.should_receive(:show_all)
    Application.new nil, []
  end
end

