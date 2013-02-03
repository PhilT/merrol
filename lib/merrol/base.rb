module Merrol
  class Base
    attr_reader :path

    def initialize
      @path = ARGV[0] || Dir.pwd
      @app_path = File.dirname(__FILE__)
    end

    def run
      @theme = Theme.new(File.join(@app_path, 'config', 'themes', 'monokai.yml'))
      @screen = Screen.new
    end
  end
end
