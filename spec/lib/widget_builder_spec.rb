require 'spec_helper'

describe WidgetBuilder do
  before(:each) do
    @mock_window = mock Gtk::Window
    Gtk::Window.stub!(:new).and_return @mock_window
  end

  it 'creates widgets' do
    YAML.stub!(:load).with('view1').and_return({'layout' => {'type' => 'Window'}})
    YAML.stub!(:load).with('view2').and_return({'layout' => {'type' => 'VBox'}})
    mock_vbox = mock Gtk::VBox
    Gtk::VBox.stub!(:new).and_return mock_vbox

    widgets = WidgetBuilder.build 'view1', 'view2'
    widgets.should == {'view1' => @mock_window, 'view2' => mock_vbox}
  end

  it 'handles typed values e.g. Gtk::TextTag::WRAP_WORD' do
    options = {'wrap_mode' => {'type' => 'TextTag', 'value' => 'WRAP_WORD'}}
    YAML.stub!(:load).with('a_view').and_return({'layout' => {'type' => 'Window'}, 'options' => options})
    @mock_window.should_receive(:wrap_mode=).with Gtk::TextTag::WRAP_WORD

    widgets = WidgetBuilder.build 'a_view'
  end

  it 'packs widget with expand, fill and padding' do
    YAML.stub!(:load).with('parent').and_return({'layout' => {'type' => 'VBox'}})
    YAML.stub!(:load).with('child').and_return({'layout' => {'type' => 'Label', 'add_to' => 'parent', 'expand' => true, 'fill' => true, 'padding' => 1}})
    mock_vbox = mock Gtk::VBox
    mock_label = mock Gtk::Label
    Gtk::VBox.stub!(:new).and_return mock_vbox
    Gtk::Label.stub!(:new).and_return mock_label
    mock_vbox.should_receive(:pack_start).with(mock_label, true, true, 1)

    widgets = WidgetBuilder.build 'parent', 'child'
  end

  it 'packs widget with default options' do
    YAML.stub!(:load).with('parent').and_return({'layout' => {'type' => 'VBox'}})
    YAML.stub!(:load).with('child').and_return({'layout' => {'type' => 'Label', 'add_to' => 'parent'}})
    mock_vbox = mock Gtk::VBox
    mock_label = mock Gtk::Label
    Gtk::VBox.stub!(:new).and_return mock_vbox
    Gtk::Label.stub!(:new).and_return mock_label
    mock_vbox.should_receive(:pack_start).with(mock_label, false, false, 0)

    widgets = WidgetBuilder.build 'parent', 'child'
  end

  it 'packs a widget that has a container' do
    YAML.stub!(:load).with('parent').and_return({'layout' => {'type' => 'Window', 'container' => 'VBox'}})
    YAML.stub!(:load).with('child').and_return({'layout' => {'type' => 'Label', 'add_to' => 'parent'}})
    mock_vbox = mock Gtk::VBox
    mock_label = mock Gtk::Label
    Gtk::VBox.stub!(:new).and_return mock_vbox
    Gtk::Label.stub!(:new).and_return mock_label
    @mock_window.should_receive(:container=).with 'VBox'
    @mock_window.should_receive(:container).and_return mock_vbox
    mock_vbox.should_receive(:pack_start).with(mock_label, false, false, 0)

    widgets = WidgetBuilder.build 'parent', 'child'
  end

  it 'adds a widget to a single container parent (Gtk::Bin)' do
    YAML.stub!(:load).with('parent').and_return({'layout' => {'type' => 'Window'}})
    YAML.stub!(:load).with('child').and_return({'layout' => {'type' => 'Label', 'add_to' => 'parent'}})
    @mock_window.stub!(:is_a?).and_return Gtk::Bin
    mock_label = mock Gtk::Label
    Gtk::Label.stub!(:new).and_return mock_label
    @mock_window.should_receive(:add).with mock_label

    widgets = WidgetBuilder.build 'parent', 'child'
  end

end

