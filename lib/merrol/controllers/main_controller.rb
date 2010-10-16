module Merrol
  class MainController < Controller
    def initialize commands, views
      super commands, views
      main_view.signal_connect('destroy') { Gtk.main_quit}
    end

    def working_dir= working_dir
      name = File.basename(working_dir)
      main_view.title = "#{name} (#{working_dir[0..-name.length - 2]})"
    end

    def numbers

    end

    def quit
      main_view.destroy
    end

    def cancel

    end

  end
end

