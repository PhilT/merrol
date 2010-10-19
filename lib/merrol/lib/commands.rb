module Merrol
  class Commands
    def initialize(window)
      @accel_group = Gtk::AccelGroup.new
      window.add_accel_group @accel_group
      load
    end

    def register controller
      @commands[controller.name.to_s].each do |command, detail|
        if detail['key'] =~ /TAB/
          Gtk::Window.toplevels.first.signal_connect('key_press_event') do |widget, event|
            if detail['key'] == Shortcut.from(event)
              controller.send(command)
            else
              false
            end
          end
        else
          @accel_group.connect "<#{APP_NAME}>/#{controller.name}/#{command}" do
            controller.send(command)
          end
        end
      end
    end

  private

    def load
      @commands = YAML.load_config 'commands'
      @commands.each do |category, commands|
        commands.each do |command, detail|
          event = Shortcut.to_event(detail['key'])
          Gtk::AccelMap.add_entry("<#{APP_NAME}>/#{category}/#{command}", event.keyval, event.state)
        end
      end
    end
  end
end

