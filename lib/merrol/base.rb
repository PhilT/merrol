module Merrol
  class Base
    attr_reader :path

    def initialize
      @path = ARGV[0] || Dir.pwd
      @app_path = File.dir(__FILE__)
    end

    def run
      @theme = Theme.new(File.join(@app_path, 'themes', 'monokai.yml'))
      @screen = Screen.new(@theme)
    end
  end
end
