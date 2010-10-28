class LibNotFoundError < StandardError; end

def check_packages
  selections = `dpkg --get-selections`
  libs = %w(libglib2.0-dev libatk1.0-dev libpango1.0-dev libgtk2.0-dev libgtksourceview2.0-dev)
  libs.each do |lib|
    raise LibNotFoundError unless selections =~ Regexp.new(lib)
  end
rescue LibNotFoundError => e
  puts 'Some packages needed for installation are missing'
  puts 'To install the rquired packages please run:'
  puts '    sudo apt-get install libglib2.0-dev libatk1.0-dev libpango1.0-dev libgtk2.0-dev libgtksourceview2.0-dev'
  puts
  exit
end

def install_ruby_gnome2
  trap("INT") { puts "\rAborted."; exit }

  puts "Some ruby libraries need to be compiled and installed to run merrol (gtk2 and gtksourceview2)"
  puts "Press ENTER to install or CTRL+C to abort"
  gets

  logfile = '/tmp/ruby-gnome2-install.log'

  package = 'ruby-gnome2-all-0.90.4'
  system "gem install pkg-config > #{logfile}"
  puts 'pkg-config installed'

  puts 'Downloading sources...'
  system "cd /tmp && wget http://downloads.sourceforge.net/ruby-gnome2/#{package}.tar.gz >> #{logfile}"

  puts 'Extracting sources...'
  system "cd /tmp && tar xf #{package}.tar.gz"

  puts 'Configuring ...'
  system "cd /tmp/#{package} && ruby extconf.rb >> #{logfile}"

  puts 'Building ...'
  system "cd /tmp/#{package} && sudo make >> #{logfile}"

  puts 'Installing ...'
  system "cd /tmp/#{package} && sudo make install >> #{logfile}"

  puts 'Done.'
end

begin
  check_packages
  require 'gtksourceview2'
rescue LoadError
  install_ruby_gnome2
end

