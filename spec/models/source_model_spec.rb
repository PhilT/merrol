require 'spec_helper'

describe SourceModel do
  it 'loads file' do
    File.stub!(:exist?).with('path').and_return true
    File.stub!(:read).with('path').and_return 'text'

    model = SourceModel.new 'path'
    model.text.should == 'text'
    model.can_undo?.should be_false
  end
end

