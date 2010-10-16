require 'spec_helper'

describe Commands do
  it 'adds an entry for a given shortcut key' do
    command_file = {'category' => {'command' => {'help' => '', 'key' => 'CTRL+ALT+SHIFT+A'}}}
    YAML.stub!(:load_config).with('commands').and_return(command_file)
    ctrl_alt_shift = Gdk::Window::CONTROL_MASK | Gdk::Window::MOD1_MASK | Gdk::Window::SHIFT_MASK
    Gtk::AccelMap.stub!(:add_entry).with('<Merrol>/category/command', Gdk::Keyval::GDK_A, ctrl_alt_shift)
    Commands.new(mock(Gtk::Window, :add_accel_group => nil))
  end

  it 'accel group is added to the window' do
    YAML.stub!(:load_config).and_return []
    mock_accel_group = mock Gtk::AccelGroup
    Gtk::AccelGroup.stub!(:new).and_return mock_accel_group
    mock_window = mock Gtk::Window
    mock_window.should_receive(:add_accel_group).with mock_accel_group
    Commands.new(mock_window)
  end

  it 'can be registered' do
    YAML.stub!(:load_config).and_return []
    mock_accel_group = mock Gtk::AccelGroup
    mock_accel_group.should_receive(:connect).with('<Merrol>/category/command').and_yield
    Gtk::AccelGroup.stub!(:new).and_return mock_accel_group
    commands = Commands.new(mock(Gtk::Window, :add_accel_group => nil))
    commands.register 'category', 'command' do
    end
  end

end

