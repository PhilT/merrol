require 'colored'

def message string
  puts string.ljust(60).green_on_black
end

def output string
  puts string.white_on_black
end

selections = `dpkg --get-selections`
libs = %w(libglib2.0-dev libatk1.0-dev libpango1.0-dev libgtk2.0-dev libgtksourceview2.0-dev)
installed = libs.select{ |lib| selections =~ Regexp.new(lib) }
if installed != libs
  message "Your system is missing some libraries."
  message "Don't worry, we're going to install them for you..."
  libs.each do |lib|
    message "Installing #{lib}..."
    output `sudo apt-get install -qq -y #{lib}`
  end
end

begin
  require 'gtksourceview2'
rescue LoadError
  if `rvm -v` =~ /command not found/
    sudo = "sudo "
  else
    message "RVM Detected - not using sudo"
  end
  message "Installing required gems (This may take a while)..."
  output `#{sudo}gem install gtksourceview2 --no-rdoc --no-ri`
  message "All done. Try running the app again."
  exit
end

