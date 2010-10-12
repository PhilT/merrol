require 'spec_helper'

describe CommandDispatcher do
  include CommandDispatcher

  before(:each) do
    load_commands
  end

  it 'call handler for given shortcut' do
    should_receive(:open).and_return true
    handle(to_event('CTRL+O')).should be_true
  end

  it 'handler ignores shortcuts with no mapping' do
    handle(to_event('Control_L')).should be_false
  end

  it 'lookup commands in given category' do
    pending
  end
end

