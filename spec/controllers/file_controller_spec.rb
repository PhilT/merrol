require 'spec_helper'

describe FileController do
  before(:each) do
    @mock_commands = mock Commands, :register => nil
    @mock_main = mock Gtk::Window
    @mock_image = mock Gtk::Image
    @mock_list = mock Gtk::ListView
    @mock_theme = mock Gtk::SourceStyleScheme
    @mock_views = {
      :main => @mock_main,
      :edit => mock(Gtk::SourceView, :theme => @mock_theme, :highlight_brackets => true),
      :file_status => @mock_image,
      :file_list => @mock_list
    }
    @mock_source_model = mock SourceModel, :style_scheme= => nil, :highlight_matching_brackets= => nil
    SourceModel.stub!(:new).and_return @mock_source_model
    @mock_views[:edit].stub!(:buffer=)
    @mock_source_model.stub!(:modified=)
    @mock_source_model.stub!(:signal_connect)
  end

  it 'creates the source models' do
    SourceModel.should_receive(:new).with('path1').and_return @mock_source_model
    SourceModel.should_receive(:new).with('path2').and_return @mock_source_model
    @mock_views[:edit].should_receive(:buffer=).once.with @mock_source_model
    @mock_source_model.should_receive(:modified=).with false
    @mock_source_model.should_receive(:style_scheme=).with @mock_theme
    @mock_source_model.should_receive(:highlight_matching_brackets=).with true

    file = FileController.new @mock_commands, @mock_views
    file.load_all ['path1', 'path2']
  end

  it 'requests source model to save' do
    @mock_views[:edit].stub!(:buffer).and_return @mock_source_model
    @mock_source_model.should_receive :save

    file = FileController.new @mock_commands, @mock_views
    file.save
  end

  it 'indicate when source model has been modified' do
    @mock_source_model.stub!(:modified?).and_return true
    @mock_source_model.should_receive(:signal_connect).with('modified_changed').and_yield
    @mock_image.should_receive(:file=).with /modified.svg/

    file = FileController.new @mock_commands, @mock_views
    file.load_all ['path']
  end

  it 'indicate when source model has been saved' do
    @mock_source_model.stub!(:modified?).and_return false
    @mock_source_model.should_receive(:signal_connect).with('modified_changed').and_yield
    @mock_image.should_receive(:file=).with /saved.svg/

    file = FileController.new @mock_commands, @mock_views
    file.load_all ['path']
  end

  describe 'switch' do

    it 'displays file_list when shortcut pressed' do
      @mock_list.should_receive :show
      @mock_main.stub! :signal_connect
      file = FileController.new @mock_commands, @mock_views
      file.switch
    end

    it 'releasing modifier hides file_list' do
      @mock_list.stub! :show
      @mock_list.should_receive :hide
      event = Gdk::EventKey.new(Gdk::Event::KEY_RELEASE)
      event.keyval = Gdk::Keyval::GDK_Control_L

      @mock_main.stub!(:signal_connect).with('key_release_event').and_yield(nil, event)
      @mock_main.should_receive(:signal_handler_disconnect) # TODO: Need to check correct id passed but can't figure out how to do this with rspec
      file = FileController.new @mock_commands, @mock_views
      file.switch
    end
  end
end

