require 'integration_helper'

describe 'ideas' do
  describe 'gedit does not' do
    it 'move past quotes or brackets when TAB pressed'
    it 'support nested quotes and brackets'
    it 'ignore TAB completion when already in TAB completion'
    it 'complete words sometimes'
  end

  it 'splits screen and switches to it when ALT+RIGHT pressed'
  it 'switches to existing split screen when ALT+RIGHT pressed'
  it 'shortcut of the day in status bar'
  it 'options to turn off shortcut of the day'

  it 'Adding a new file automatically adds spec/test file'

  describe 'snippets' do
    it 'handle multi-choice parameters by TABing through and pressing ENTER on the desired option'
  end
end

