require 'bundler/setup'

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter '/spec/'
    add_filter '/bin/'

    add_group 'Gooy', 'gooy/'
    add_group 'Lib', 'lib/'
  end
end

require 'minitest/spec'
require 'support/file_system'

require 'merrol'
include Merrol

module Gtk
  def self.main_quit
    $main_quit_called = true
  end
end

FakeFS.deactivate!

require 'minitest/autorun'

