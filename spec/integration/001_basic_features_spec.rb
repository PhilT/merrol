describe 'Editor' do
  before(:each) do
    @the_contents = 'Some prewritten text. '
    create_file 'the_file', :containing => @the_contents
  end

  it 'can load and save a file' do
    pressing 'CTRL+O'
    shows 'open'

    entering 'the_file', :into => 'open.search_field'
    displays 'the_file', :in => 'open.results'

    pressing 'ENTER'
    loads @the_contents, :into => 'editor'

    entering 'some text', :into => 'editor'
    displays 'some text', :in => 'editor'

    pressing 'CTRL+S'
    saves @the_contents + 'some text', :in => 'the_file'

    pressing 'CTRL+Q'
    quits
  end
end

