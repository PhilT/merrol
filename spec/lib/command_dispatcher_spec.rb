require 'spec_helper'

describe CommandDispatcher do
  before(:each) do
    @window = Window.new('Window', [])
  end

  after(:each) do
    @window.stub!(:save_state)
    @window.destroy
  end

  it 'call handler for given shortcut' do
    @window.should_receive(:open)
    @window.handle('CTRL+O').should be_true
  end

  it 'handler ignores shortcuts with no mapping' do
    @window.handle('CTRL').should be_false
  end

  it 'lookup commands in given category' do
    pending
  end
end

