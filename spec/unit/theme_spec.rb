require 'spec_helper'

describe Merrol::Theme do
  subject { Merrol::Theme.new('lib/merrol/config/themes/monokai.yml') }

  it 'loads theme' do
    subject.keyword.must_equal 0xF92672
  end

  it 'sets up the color pairs' do
    subject.keyword
  end
end
