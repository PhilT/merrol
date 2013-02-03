require 'integration_helper'

describe 'Starting application' do
  subject { Merrol::Base.new }
  it 'causes screen to be initialized' do
    subject.run
    line(0).must_match /^no file/
  end
end
