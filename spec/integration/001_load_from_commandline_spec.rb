require 'integration_helper'

describe 'Editor' do
  before(:each) do
    @the_contents = 'Some prewritten text. '
    create_file 'the_file', :containing => @the_contents
#    Gtk::Window.toplevels.each { |window| window.destroy }
  end

  after(:each) do
    destroy_file 'the_file'
  end

  it 'loads a file from the commandline' do
    application = Application.new '', ['the_file']
    loads @the_contents, :into => :edit, :test_against => application
  end

  it 'does not fail when no files specified on commandline' do
    application = Application.new '', []
    displays '', :in => :edit, :test_against => application
  end
end

