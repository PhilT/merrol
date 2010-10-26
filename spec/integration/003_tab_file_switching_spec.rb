require 'integration_helper'

describe 'CTRL+TAB file switching' do
  before(:each) do
    create_file 'a_file', :containing => some_text_in('a_file')
    create_file 'another_file', :containing => some_text_in('another_file')
    create_file 'a_third_file', :containing => some_text_in('a_third_file')
  end

  after(:each) do
    destroy_file 'a_file'
    destroy_file 'another_file'
    destroy_file 'a_third_file'
  end

  it 'switches to third file after loading' do
    pressing 'CTRL+TAB'
    does_not_show :file_list

    load_file 'a_file'
    load_file 'another_file'
    load_file 'a_third_file'
    displays some_text_from('a_third_file'), :in => :edit

    pressing 'CTRL+TAB'
    does_not_show :file_list
    displays some_text_from('another_file'), :in => :edit

    releasing 'CTRL'
    pressing 'CTRL+TAB'
    does_not_show :file_list
    displays some_text_from('a_third_file'), :in => :edit

    pressing 'CTRL+TAB'
    shows :file_list
    highlights 'a_file', :in => :file_list
    displays ['another_file', 'a_third_file', 'a_file'], :in => :file_list

    releasing 'CTRL'
    hides :file_list
    displays some_text_from('a_file'), :in => :edit

    pressing 'CTRL+TAB'
    does_not_show :file_list
    releasing 'CTRL'
  end

end

