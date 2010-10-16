module Merrol
  class MainController < Controller
    def initialize view, working_dir, commands
      @view = view
      @view.signal_connect('destroy') { Gtk.main_quit}
      commands.register('application', 'quit') {quit}
      name = File.basename(working_dir)
      @view.title = "#{name} (#{working_dir[0..-name.length - 2]})"
    end

    def complete
      false
    end

    def quit
      @view.destroy
    end

  end
end

