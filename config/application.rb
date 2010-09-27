require_relative('boot')


require 'gtk2'
require 'fileutils'
require 'yaml'

require_relative('')
Bundler.require(:default)

%w(app/helpers app lib).each do |dir|
  Dir["#{APP_ROOT}/#{dir}/**/*.rb"].each do |file|
    require file unless File.basename(file, '.rb') == 'controller'
  end
end


class Application < Application
end

Application.initialize!

