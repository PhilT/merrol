module Merrol
  class Application
    include CommandDispatcher

    attr_reader :widgets

    def self.start_in working_dir, arguments
      Application.new working_dir, arguments
    end

    def save
      File.open(@filepaths.first, 'w') {|f| f.write(@widgets['editor'].buffer.text) }
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
    def initialize working_dir, filepaths
      load_commands
      @filepaths = filepaths
      @widgets = WidgetBuilder.build 'main', 'status_bar', 'file_path', 'scroll_bars', 'editor'
      main = @widgets['main']
      load_files(@filepaths, @widgets['editor'])

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
      filepath = filepaths.first
      if filepath
        @widgets['editor'].buffer.text = File.read(filepath) if File.exist?(filepath)
        @widgets['file_path'].text = filepath
      end
    end
  end
end

