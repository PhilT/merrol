module Merrol
  class Application
    attr_reader :views

    def self.start_in working_dir, arguments
      Application.new working_dir, arguments
    end

protected
    def initialize working_dir, paths
      @views = WidgetBuilder.build :main, :status_bar, :hbox, :file_list, :scroll_bars, :edit, :file_status, :file_path
      main_view = @views[:main]

      commands = Commands.new main_view
      main = MainController.new commands, @views
      main.working_dir = working_dir

      edit = EditController.new commands, @views

      file = FileController.new commands, @views
      file.load_all paths
      @views[:file_list].list = paths
      @views[:file_path].text = paths.last
      @views[:edit].grab_focus

      main_view.show_all
    end

  end
end

