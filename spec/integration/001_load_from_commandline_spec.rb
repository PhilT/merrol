require 'integration_helper'

describe 'Editor' do
  before(:each) do
    @the_contents = 'Some prewritten text. '
    create_file 'the_file', :containing => @the_contents
  end

  after(:each) do
    destroy_file 'the_file'
    Gtk::Window.toplevels.each { |window| window.stub!(:save_state); window.destroy }
  end

  it 'loads a file from the commandline' do
    Application.start_in '', ['the_file']
    loads @the_contents, :into => 'view'
  end

  it 'does not fail when no files specified on commandline' do
    Application.start_in '', []
    displays '', :in => 'view'
  end
end

