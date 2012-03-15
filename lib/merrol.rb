require "bundler/setup"
require 'gtk2'
require 'gtksourceview2'
require 'highline'
require 'yaml'
require 'active_support/inflector'
require 'observer'

APP_NAME = "Merrol"
WORKING_DIR = Dir.getwd

def excluded? file
  file =~ /keyboard_map/
end

merrol_dir = File.join(File.direname(__FILE__), 'merrol')
require File.join(merrol_dir, 'controllers', 'controller')
Dir[File.join(merrol_dir, '**', '*.rb')].each { |file| require file unless excluded?(file)}

