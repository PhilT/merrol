module Merrol
  class Application
    attr_reader :views, :controllers

    def initialize working_dir, paths
      @views = WidgetBuilder.build :main, :status_bar, :hbox, :file_list, :scroll_bars, :edit, :file_status, :file_path
      main_view = @views[:main]
      commands = Commands.new main_view

      @controllers = {}
      controller_paths = Dir[File.app_relative('lib/merrol/controllers') + '/*_controller.rb']
      controller_paths.each do |controller|
        controller = File.basename(controller, '.rb')
        name = controller.gsub(/_controller/, '')
        @controllers[name] = eval(controller.classify).new commands, @views
      end

      @controllers['main'].working_dir = working_dir
      @controllers['file'].load_all paths

      @views[:file_list].list = paths
      @views[:file_path].text = paths.last if paths.last
      @views[:edit].grab_focus

      main_view.show_all
    end
  end
end

