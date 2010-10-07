require 'gtk2'
require 'gtksourceview2'
require 'yaml'

APP_NAME = "Merrol"

Dir["#{File.dirname(__FILE__)}/merrol/**/*.rb"].each { |file| require(file) }

Window.new(APP_NAME)

