require 'spec_helper'

describe Base do
  it 'sets project path' do
    Dir.stubs(:pwd).returns 'current dir'
    subject = Merrol::Base.new
    subject.path.must_equal 'current dir'
  end

  it 'sets project path when passed in on commandline' do
    ARGV[0] = 'dir'
    subject = Merrol::Base.new
    subject.path.must_equal 'dir'
  end
end
