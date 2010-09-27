require_relative('../spec_helper')
require_relative('../../lib/config')
describe Config do
  it 'loads YAML files' do
    stub!(:Dir).with(File.dirname(__FILE__) + '/../config/*.yml').and_return %w(commands)
    Config.load
  end
end

