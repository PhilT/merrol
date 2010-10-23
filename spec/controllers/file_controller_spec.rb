require 'spec_helper'

describe FileController do
  before(:each) do
    @mock_commands = mock Commands, :register => nil
    @mock_main = mock Gtk::Window
    @mock_image = mock Gtk::Image
    @mock_list = mock Gtk::ListView, :selected_to_top => nil
    @mock_theme = mock Gtk::SourceStyleScheme
    @mock_edit = mock(Gtk::SourceView, :theme => @mock_theme, :highlight_brackets => true)
    @mock_views = {
      :main => @mock_main,
      :edit => @mock_edit,
      :file_status => @mock_image,
      :file_list => @mock_list
    }
    @mock_source_model = mock_source_model
    SourceModel.stub!(:new).and_return @mock_source_model
    @mock_edit.stub!(:buffer=)
  end

  def mock_source_model
    mock SourceModel, :style_scheme= => nil, :highlight_matching_brackets= => nil, :modified= => nil, :signal_connect => nil
  end

  it 'creates the source models' do
    SourceModel.should_receive(:new).with('path1').and_return @mock_source_model
    SourceModel.should_receive(:new).with('path2').and_return @mock_source_model
    @mock_edit.should_receive(:buffer=).once.with @mock_source_model
    @mock_source_model.should_receive(:modified=).with false
    @mock_source_model.should_receive(:style_scheme=).with @mock_theme
    @mock_source_model.should_receive(:highlight_matching_brackets=).with true

    file = FileController.new @mock_commands, @mock_views
    file.load_all ['path1', 'path2']
  end

  it 'requests source model to save' do
    @mock_edit.stub(:buffer).and_return @mock_source_model
    @mock_source_model.should_receive :save

    file = FileController.new @mock_commands, @mock_views
    file.save
  end

  it 'indicate when source model has been modified' do
    @mock_source_model.stub(:modified?).and_return true
    @mock_source_model.should_receive(:signal_connect).with('modified_changed').and_yield
    @mock_image.should_receive(:file=).with /modified.svg/

    file = FileController.new @mock_commands, @mock_views
    file.load_all ['path']
  end

  it 'indicate when source model is not modified' do
    @mock_source_model.stub(:modified?).and_return false
    @mock_source_model.should_receive(:signal_connect).with('modified_changed').and_yield
    @mock_image.should_receive(:file=).with /saved.svg/

    file = FileController.new @mock_commands, @mock_views
    file.load_all ['path']
  end

  describe '#switch' do
    before(:each) do
      @mock_list.stub :show
      @mock_list.stub :next
      @mock_list.stub(:selected).and_return 'path1'

      @mock_edit.stub :switch
    end

    context 'when shortcut pressed' do
      before(:each) do
        @mock_main.stub :signal_connect
        @next_mock_source_model = mock_source_model
        SourceModel.stub(:new).with('path1').and_return @mock_source_model
        SourceModel.stub(:new).with('path2').and_return @next_mock_source_model
        @file = FileController.new @mock_commands, @mock_views
        @file.stub :id=
        @file.load_all ['path1', 'path2']
      end

      it 'displays file_list when shortcut pressed' do
        @mock_list.should_receive :show
        @file.switch
      end

      it 'highlight second file in the list' do
        @mock_list.should_receive(:next)
        @mock_list.should_receive(:selected).and_return 'path2'
        @mock_edit.should_receive(:buffer=).with(@next_mock_source_model)
        @file.switch
      end
    end

    context 'when releasing TAB' do
      it 'does nothing' do
        @event = Gdk::EventKey.new(Gdk::Event::KEY_RELEASE)
        @event.keyval = Gdk::Keyval::GDK_Tab
        file = FileController.new @mock_commands, @mock_views
        @mock_main.stub(:signal_connect).and_yield nil, @event
        @mock_list.should_not_receive :hide
        @mock_main.should_not_receive :signal_handler_disconnect
        file.switch
      end
    end

    context 'when releasing modifier' do
      before(:each) do
        @mock_edit.stub(:scroll_to_cursor)
        @event = Gdk::EventKey.new(Gdk::Event::KEY_RELEASE)
        @event.keyval = Gdk::Keyval::GDK_Control_L
        @mock_list.stub :hide
        @mock_main.stub :signal_handler_disconnect
      end

      it 'moves selected file to the top of the list' do
        file = FileController.new @mock_commands, @mock_views
        @mock_main.stub(:signal_connect).and_yield nil, @event
        @mock_list.should_receive :selected_to_top
        file.switch
      end

      it 'hides file_list' do
        @mock_list.should_receive :hide

        @mock_main.stub!(:signal_connect).with('key_release_event').and_yield(nil, @event).and_return 1
        file = FileController.new @mock_commands, @mock_views
        file.should_receive(:handler_id=).with(1)
        file.should_receive(:handler_id).and_return 1
        file.switch
      end

      it 'handler_id from key release event is used to disconnect handler' do
        @mock_main.should_receive(:signal_connect).with('key_release_event').and_return(1)
        file = FileController.new @mock_commands, @mock_views
        file.switch
        file.send(:handler_id).should == 1
      end

      it 'disconnect handler is called with the correct handler id' do
        @mock_main.stub!(:signal_connect).with('key_release_event').and_yield(nil, @event)
        @mock_main.should_receive(:signal_handler_disconnect).with 1
        file = FileController.new @mock_commands, @mock_views
        file.send(:handler_id=, 1)
        file.switch
      end
    end
  end
end

