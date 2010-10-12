module Merrol
  class Application
    include CommandDispatcher

    def initialize working_dir, arguments
      load_commands

      signal_connect('destroy') do
        save_state
        false
      end
    end

    def complete

    end

    def quit
      destroy
    end

    def save_state
      Gtk.main_quit
    end

    def load_files filepaths, view
      if filepaths.first
        view.buffer.text = File.read(filepaths.first)
        @fileinfo.text = filepaths.first
      end
    end
  end
end

