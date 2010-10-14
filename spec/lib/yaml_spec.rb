require 'spec_helper'

describe YAML do
  it 'loads a configuration file' do
    File.should_receive(:app_relative).with('config/file.yml')
    mock_file = mock File
    File.stub!(:open).and_return mock_file
    YAML.stub!(:load).with(mock_file)

    YAML.load_config('file')
  end

  it 'loads a view' do
    File.should_receive(:app_relative).with('lib/merrol/views/file.yml')
    mock_file = mock File
    File.stub!(:open).and_return mock_file
    YAML.stub!(:load).with(mock_file)

    YAML.load_view('file')
  end

  it 'raises method not found exception when unknown load method specified' do
    lambda{ YAML.load_something('file') }.should raise_error NoMethodError
  end
end

