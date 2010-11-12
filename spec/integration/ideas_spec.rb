require 'integration_helper'

describe 'ideas' do
  describe 'gedit does not' do
    it 'move past quotes or brackets when TAB pressed'
    it 'support nested quotes and brackets'
    it 'ignore TAB completion when already in TAB completion'
    it 'complete words all the time'
    it 'paste at current cursor location all the time'
    it 'handle non-matching quotes in a regex within an array' do
      pending # This fails to highlight correctly: [/'/]
    end
 end

  it 'splits screen and switches to it when ALT+RIGHT pressed'
  it 'switches to existing split screen when ALT+RIGHT pressed'
  it 'shortcut of the day in status bar'
  it 'options to turn off shortcut of the day'
  it 'Adding a new file automatically adds spec/test file'
  it 'opening a previously opened directory reloads the previously open files'

  describe 'snippets' do
    it 'handle multi-choice parameters by TABing through and pressing ENTER on the desired option'
  end
end

