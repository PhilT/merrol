require 'spec_helper'

describe CommandDispatcher do
  before(:each) do
    @app = Application.start_in '', []
  end

  after(:each) do
    Gtk::Window.toplevels.each { |window| window.stub!(:save_state); window.destroy }
  end

  it 'call handler for given shortcut' do
    @app.should_receive(:open)
    @app.handle(to_event('CTRL+O')).should be_true
  end

  it 'handler ignores shortcuts with no mapping' do
    @app.handle(to_event('CTRL')).should be_false
  end

  it 'lookup commands in given category' do
    pending
  end
end

