require 'gtk2'
require 'gtksourceview2'
require 'yaml'

APP_NAME = "Merrol"
WORKING_DIR = Dir.getwd

require "#{File.dirname(__FILE__)}/merrol/command_dispatcher"
merrol_path = "#{File.dirname(__FILE__)}/merrol/**/*.rb"
to_include = Dir[merrol_path]
to_include.each { |file| require file unless file.include?('keyboard_map') }

