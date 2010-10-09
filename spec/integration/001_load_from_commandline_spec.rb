$LOAD_PATH << 'lib'
require 'merrol'
require 'integration_helper'

describe 'Editor' do
  before(:each) do
    @the_contents = 'Some prewritten text. '
    create_file 'the_file', :containing => @the_contents
    Gtk::Window.toplevels.each { |window| window.stub!(:save_state); window.destroy }
    @window = nil
  end

  after(:each) do
    destroy_file 'the_file'
    @window.stub!(:save_state)
    @window.destroy
  end

  it 'loads a file from the commandline' do
    @window = Window.new('', ['the_file'])
    loads @the_contents, :into => 'view'
  end

  it 'does not fail when no files specified on commandline' do
    @window = Window.new('', [])
    displays '', :in => 'view'
  end
end

