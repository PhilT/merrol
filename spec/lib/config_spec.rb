require 'spec_helper'
require 'lib/config'

describe Config do
  before(:each) do
    Dir.stub!()
  end

  it 'loads YAML files' do
    stub!(:Dir).with(File.dirname(__FILE__) + '/../config/*.yml').and_return %w(commands)
    Config.load
  end

  it 'exposes parameters as methods' do

    Config.a_constant.should == 'a constant'
  end
end

