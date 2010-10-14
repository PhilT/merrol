require 'integration_helper'

describe 'Editor' do
  it 'is not shown' do
    window = @application.widgets['main']
    window.show_all
    window.should_not be_visible
  end

  it 'does not quit main loop' do
    window = @application.widgets['main']
    @application.save_state
  end

  it 'quits' do
    quits_by_pressing 'CTRL+Q'
  end
end

