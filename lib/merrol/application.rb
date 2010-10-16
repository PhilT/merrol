module Merrol
  class Application
    attr_reader :views

    def self.start_in working_dir, arguments
      Application.new working_dir, arguments
    end

protected
    def initialize working_dir, filepaths
      @views = WidgetBuilder.build 'main', 'status_bar', 'file_status', 'file_path', 'scroll_bars', 'editor'
      main = @views['main']

      commands = Commands.new(main)
      status_bar = StatusBarController.new @views['status_bar'], @views['file_status'], @views['file_path']
      MainController.new main, working_dir, commands
      EditorController.new @views['editor'], status_bar, filepaths, commands

      main.show_all
    end

  end
end

