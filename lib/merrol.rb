require 'gtk2'
require 'gtksourceview2'

require 'merrol/lib/paths'
require 'merrol/lib/version'

%w(widget container scroll_view window row column text_view shortcut).each do |file|
  require "merrol/gooy/#{file}"
end

require 'merrol/views/application'

