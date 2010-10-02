require 'rubygems'

require 'gtk2'
require 'gtksourceview2'
require 'fileutils'
require 'yaml'
require 'bundler'
Bundler.setup

APP_NAME = "RailED"

require_relative '../lib/config.rb'
Config.load

Application.initialize!

