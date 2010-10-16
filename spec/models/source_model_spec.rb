require 'spec_helper'

describe SourceModel do
  before(:each) do
    File.stub!(:exist?).with('path').and_return true
    File.stub!(:read).with('path').and_return 'text'
    @model = SourceModel.new 'path'
  end

  it 'loads file' do
    @model.text.should == 'text'
    @model.can_undo?.should be_false
    @model.modified?.should be_false
  end

  it 'saves a file' do
    mock_file = mock File
    mock_file.should_receive(:write).with 'text'
    File.should_receive(:open).with('path', 'w').and_yield(mock_file)

    @model.text = 'text'
    @model.save
    @model.modified?.should be_false
  end
end

