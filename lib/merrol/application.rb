module Merrol
  class Application
    attr_reader :views

    def self.start_in working_dir, arguments
      Application.new working_dir, arguments
    end

protected
    def initialize working_dir, paths
      @views = WidgetBuilder.build :main, :status_bar, :file_status, :file_path, :scroll_bars, :edit
      main_view = @views[:main]

      commands = Commands.new main_view
      main = MainController.new commands, @views
      main.working_dir = working_dir

      edit = EditController.new commands, @views
      edit.load_all paths

      main_view.show_all
    end

  end
end

