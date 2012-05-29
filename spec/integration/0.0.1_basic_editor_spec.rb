describe '0.0.1 - Basic Editor' do
  before { starting_application }
  after { quit_application }

  it 'has version and path in the title bar' do
    shows "Merrol v#{Merrol::VERSION}", :for => :title, :in => 'merrol'
    shows project_root, :for => :title, :in => 'merrol'
  end

  it 'opens new file with open panel (CTRL+N)' do
    skip
    pressing 'CTRL+N'
    shows 'new'
    shows project_root_paths, :in => 'new.paths'

    entering 'li'
    shows 'lib', :in => 'new.paths'

    pressing 'TAB'
    shows 'lib/', :in => 'new.path'
    shows ['lib/models/'], :in => 'new.paths'

    entering 'contollers/main.rb'
    shows 'lib/controllers/main.rb', :in => 'new.path'
    shows [], :in => 'new.paths'

    pressing 'ENTER'
    shows 'lib/controllers/main.rb', :in => 'editor1'
    hides 'new'
  end

  it 'opens files with fuzzy matcher (CTRL+O)' do
    skip
    pressing 'CTRL+O'
    shows 'open'
    shows project_root_paths, :in => 'open'

    entering 'a file name'
    pressing 'ENTER'
    shows 'the file', :in => 'editor1'
    hides 'open'
  end

  it 'closes fuzzy file open (ESC)' do
    skip
    pressing 'CTRL+O'
    shows 'open'

    pressing 'ESC'
    hides 'open'
  end

  it 'saves both test and code (CTRL+S)' do
    skip
    pressing 'CTRL+O'
    entering 'a_file_name'
  end

  it 'shows keyboard shortcuts (F1)' do
    skip

  end
end

