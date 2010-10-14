require 'integration_helper'

describe 'ideas' do
  describe 'gedit does not' do
    it 'move past quotes or brackets when TAB pressed'
    it 'support nested quotes and brackets'
    it 'ignore TAB completion when already in TAB completion'
  end

  it 'splits screen and switches to it when ALT+RIGHT pressed'
  it 'switches to existing split screen when ALT+RIGHT pressed'
  it 'shortcut of the day in status bar'
  it 'options to turn off shortcut of the day'

  it 'giving a filename _spec.rb inserts the spec.rb template (see config/templates)'

  describe 'snippets' do
    it 'handle multi-choice parameters by TABing through and pressing ENTER on the desired option'
  end
end

