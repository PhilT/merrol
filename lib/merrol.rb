require_relative  'prerequisites'

require 'gtk2'
require 'gtksourceview2'
require 'yaml'
require 'active_support/inflector'
require 'observer'

APP_NAME = "Merrol"
WORKING_DIR = Dir.getwd

require "#{File.dirname(__FILE__)}/merrol/controllers/controller"
merrol_path = "#{File.dirname(__FILE__)}/merrol/**/*.rb"
to_include = Dir[merrol_path]
to_include.each { |file| require file unless file.include?('keyboard_map') }

