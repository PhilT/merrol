require 'integration_helper'

describe 'Startup' do

  it 'sets the working dir' do
    $application.views[:main].title.should =~ /merrol \(\/home\/.*\)/
  end

  context 'when CTRL+Q pressed' do
    it 'quits' do
      quits_by_pressing 'CTRL+Q'
    end
  end
end

