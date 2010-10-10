require 'gtk2'
require 'gtksourceview2'
require 'yaml'

APP_NAME = "Merrol"
WORKING_DIR = Dir.getwd

$LOAD_PATH << 'lib/merrol'
require 'command_dispatcher'
require 'config'
require 'window'
require 'views/source_view'

