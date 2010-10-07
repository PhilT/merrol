require 'spec_helper'

describe CommandDispatcher do
  it 'call handler for given shortcut' do
    window = Window.new('Window')
    window.should_receive(:open)
    window.handle('CTRL+O').should be_true
  end

  it 'handler ignores shortcuts with no mapping' do
    window = Window.new('Window')
    window.handle('CTRL').should be_false
  end

  it 'lookup commands in given category' do
    pending
  end
end

