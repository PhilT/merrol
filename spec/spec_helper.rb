if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter '/spec/'
    add_filter '/autotest/'
    add_filter '/bin/'
    add_filter 'prerequisites.rb'

    add_group 'Controllers', 'controllers/'
    add_group 'Models', 'models/'
    add_group 'GTK', 'gtk/'
    add_group 'Lib', 'lib/merrol/lib/'
  end
end

$LOAD_PATH << 'lib'
require 'merrol'
include Merrol

