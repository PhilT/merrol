require 'curses'
require 'yaml'
require 'ostruct'

%w(version base keys theme screen).each do |path|
  require "merrol/#{path}"
end
