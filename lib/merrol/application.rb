module Merrol
  class Application
    include CommandDispatcher

    attr_reader :widgets

    def self.start_in working_dir, arguments
      Application.new working_dir, arguments
    end

    def complete
      false
    end

    def quit
      @widgets['main'].destroy
    end

    def save_state
      Gtk.main_quit
    end

protected
    def initialize working_dir, arguments
      load_commands

      @widgets = WidgetBuilder.build 'main', 'status_bar', 'file_path', 'scroll_bars', 'editor'
      main = @widgets['main']
      load_files(arguments, @widgets['editor'])

      main.signal_connect('destroy') do
        save_state
        false
      end

      main.signal_connect('key_press_event') do |w, e|
        handle(e)
      end

      name = File.basename(working_dir)
      main.title = "#{name} (#{working_dir[0..-name.length - 2]})"
      main.show_all
    end

    def load_files filepaths, view
      if filepaths.first
        @widgets['editor'].buffer.text = File.read(filepaths.first)
        @widgets['file_path'].text = filepaths.first
      end
    end
  end
end

