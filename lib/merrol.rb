require 'gtk2'
require 'gtksourceview2'
require 'yaml'

APP_NAME = "Merrol"
WORKING_DIR = Dir.getwd

$LOAD_PATH << 'lib/merrol'
require 'gtk/widget'
require 'gtk/window'
require 'gtk/source_view'
require 'file'
require 'command_dispatcher'
require 'config'
require 'application'

