# ####sudo apt-get install ruby-gnome2
# sudo apt-get install libglib2.0-dev libatk1.0-dev libpango1.0-dev libgtk2.0-dev
# wget http://sourceforge.net/projects/ruby-gnome2/files/ruby-gnome2/ruby-gnome2-0.90.1/ruby-gtk2-0.90.1.tar.gz/download
# gem install pkg-config
# ruby extconf.rb
# sudo make
# sudo make install
#
# gem install rspec-rails --pre

require 'gtk2'
window = Gtk::Window.new


window = Gtk::Window.new
window.signal_connect("delete_event") do
  puts "delete event occurred"
  #true
  false
end

window.signal_connect("destroy") do |w|
  puts "destroy event occurred"
  Gtk.main_quit
end

window.show
Gtk.main

