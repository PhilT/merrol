require 'spec_helper'

describe Merrol do
  it 'requires correct files' do
    VERSION.must_be_instance_of String
  end
end
