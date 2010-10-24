require 'integration_helper'

describe 'CTRL+TAB file switching' do
  before(:each) do
    @contents_of_a_file = 'Contents of a file.'
    @contents_of_another_file = 'Contents of another file.'
    create_file 'a_file', :containing => @contents_of_a_file
    create_file 'another_file', :containing => @contents_of_another_file
  end

  after(:each) do
    destroy_file 'a_file'
    destroy_file 'another_file'
  end

  it 'switches to second file' do
    pressing 'CTRL+TAB'
    does_not_show :file_list

    load_file 'a_file'
    load_file 'another_file'
    pressing 'CTRL+TAB'
    shows :file_list
    displays ['another_file', 'a_file'], :in => :file_list
  end
end

