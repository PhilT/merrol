require 'spec_helper'

describe File do
  it 'returns full path given a path relative to the app root' do
    File.stub!(:dirname).and_return '/path/to/dir_of_file'
    File.app_relative('config/file.ext').should == '/path/config/file.ext'
  end
end

