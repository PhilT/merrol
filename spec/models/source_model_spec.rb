require 'spec_helper'

describe SourceModel do
  before(:each) do
      YAML.stub!(:load_config).with('language').and_return []
  end

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

  describe 'language' do
    before(:each) do
      File.stub!(:exist?).and_return true
      File.stub!(:read).and_return 'text'
      YAML.stub!(:load_config).with('language').and_return({'ruby' => {'pattern' => '.rb Rakefile', 'bang' => 'ruby'} })
    end

    it 'set based on extension' do
      model = SourceModel.new 'path/file.rb'
      model.language.name.should == 'Ruby'
    end

    it 'set based on filename' do
      model = SourceModel.new 'Rakefile'
      model.language.name.should == 'Ruby'
    end

    it 'set based on bang line (#!/usr/bin/env ruby)' do
      File.stub!(:read).and_return "#!/usr/bin/env ruby\ncontent"
      model = SourceModel.new 'some_script'
      model.language.name.should == 'Ruby'
    end

    it 'does not set based on bang line that accidentally matches' do
      File.stub!(:read).with('path').and_return "puts 'I love ruby'"
      model = SourceModel.new 'some_script'
      model.language.should be_nil
    end

    it 'set based on existence of a file and pattern' do
      File.stub!(:exist?).with('file.rb').and_return true
      File.stub!(:exist?).with('config/routes.rb').and_return true
      YAML.stub!(:load_config).with('language').and_return({'rubyonrails' => {'pattern' => '.rb', 'exists' => 'config/routes.rb'} })
      model = SourceModel.new 'file.rb'
      model.language.name.should == 'RubyOnRails'
    end

    it 'set based on pattern and file not existing' do
      File.stub!(:exist?).with('file.rb').and_return true
      File.stub!(:exist?).with('config/routes.rb').and_return false
      yaml = {'rubyonrails' => {'pattern' => '.rb', 'exists' => 'config/routes.rb'}, 'ruby' => {'pattern' => '.rb Rakefile'} }
      YAML.stub!(:load_config).with('language').and_return yaml
      model = SourceModel.new 'file.rb'
      model.language.name.should == 'Ruby'
    end

  end



end

