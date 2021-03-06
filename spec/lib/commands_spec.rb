require 'spec_helper'

describe Commands do
  before(:each) do
    @mock_accel_group = mock Gtk::AccelGroup
    Gtk::AccelGroup.stub!(:new).and_return @mock_accel_group
    Gtk::AccelMap.stub!(:add_entry)
  end

  it 'adds an entry for a given shortcut key' do
    command_file = {'category' => {'command' => {'help' => '', 'key' => 'CTRL+ALT+SHIFT+A'}}}
    YAML.stub!(:load_config).with('commands').and_return(command_file)
    ctrl_alt_shift = Gdk::Window::CONTROL_MASK | Gdk::Window::MOD1_MASK | Gdk::Window::SHIFT_MASK
    Gtk::AccelMap.stub!(:add_entry).with('<Merrol>/category/command', Gdk::Keyval::GDK_A, ctrl_alt_shift)
    Commands.new(mock(Gtk::Window, :add_accel_group => nil))
  end

  it 'accel group is added to the window' do
    YAML.stub!(:load_config).and_return []
    mock_window = mock Gtk::Window
    mock_window.should_receive(:add_accel_group).with @mock_accel_group
    Commands.new(mock_window)
  end

  it 'can be registered' do
    YAML.stub!(:load_config).and_return({'main' => {'a_command' => {'help' => '', 'key' => 'CTRL+O'}, 'another_command' => {'help' => '', 'key' => 'CTRL+T'}} })
    @mock_accel_group.should_receive(:connect).with('<Merrol>/main/a_command').and_yield
    @mock_accel_group.should_receive(:connect).with('<Merrol>/main/another_command').and_yield
    Gtk::AccelGroup.stub!(:new).and_return @mock_accel_group
    commands = Commands.new(mock(Gtk::Window, :add_accel_group => nil))
    mock_controller = mock MainController, :class => MainController, :name => :main
    mock_controller.should_receive :a_command
    mock_controller.should_receive :another_command
    commands.register mock_controller
  end

  it 'registers special TAB case' do
    YAML.stub!(:load_config).and_return({'main' => {'a_command' => {'help' => '', 'key' => 'CTRL+TAB'}} })
    Gtk::Window.stub_chain(:toplevels, :first, :signal_connect).with('key_press_event')
    mock_controller = mock MainController, :class => MainController, :name => :main
    commands = Commands.new(mock(Gtk::Window, :add_accel_group => nil))
    commands.register mock_controller
  end

  it 'command sent when special TAB shortcut pressed' do
    YAML.stub!(:load_config).and_return({'main' => {'a_command' => {'help' => '', 'key' => 'CTRL+TAB'}} })
    Gtk::Window.stub_chain(:toplevels, :first, :signal_connect).with('key_press_event').and_yield(nil, Shortcut.to_event('CTRL+TAB'))
    mock_controller = mock MainController, :class => MainController, :name => :main
    mock_controller.should_receive(:send).with('a_command')
    commands = Commands.new(mock(Gtk::Window, :add_accel_group => nil))
    commands.register mock_controller
  end

  it 'key ignored if not special case shortcut' do
    YAML.stub!(:load_config).and_return({'main' => {'a_command' => {'help' => '', 'key' => 'CTRL+TAB'}} })
    Gtk::Window.stub_chain(:toplevels, :first, :signal_connect).with('key_press_event').and_yield(nil, Shortcut.to_event('CTRL+A'))
    mock_controller = mock MainController, :class => MainController, :name => :main
    mock_controller.should_not_receive(:send).with('a_command')
    commands = Commands.new(mock(Gtk::Window, :add_accel_group => nil))
    commands.register mock_controller
  end
end

