require 'spec_helper'

describe SourceModel do
  it 'loads file' do
    File.stub!(:exist?).with('path').and_return true
    File.stub!(:read).with('path').and_return 'text'
    model = SourceModel.new 'path'
    model.text.should == 'text'
    model.can_undo?.should be_false
    model.modified?.should be_false
  end

  it 'saves a file' do
    File.stub!(:exist?).with('path').and_return false
    model = SourceModel.new 'path'
    mock_file = mock File
    mock_file.should_receive(:write).with 'text'
    File.should_receive(:open).with('path', 'w').and_yield(mock_file)

    model.text = 'text'
    model.save
    model.modified?.should be_false
  end

  it 'sets language' do
    YAML.stub!(:load_config).with('language').and_return({'ruby' => {'pattern' => '.rb .rake Rakefile Gemfile .gemspec .ru'} })
    model = SourceModel.new 'path/file.rb'
    model.language.name.should == 'Ruby'
  end


end

