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
            if detail['key'] == to_key(event)
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
          keyval, modifiers = to_keyval(detail['key'])
          Gtk::AccelMap.add_entry("<#{APP_NAME}>/#{category}/#{command}", keyval, modifiers)
        end
      end
    end

    def to_key event
      keys = []
      keys << "CTRL" if event.state.control_mask?
      keys << "ALT" if event.state.mod1_mask?
      keys << "SHIFT" if event.state.shift_mask?
      unmodified_keyval = Gdk::Keymap.default.lookup_key(event.hardware_keycode, 0, 0)
      keys << Gdk::Keyval.to_name(unmodified_keyval).upcase
      keys.join('+')
    end

    def to_keyval key
      key = {'ESC' => 'ESCAPE', 'ENTER' => 'RETURN'}[key] || key
      state = 0
      state |= Gdk::Window::CONTROL_MASK if key =~ /CTRL+/
      state |= Gdk::Window::MOD1_MASK if key =~ /ALT+/
      state |= Gdk::Window::SHIFT_MASK if key =~ /SHIFT+/
      keyval = Gdk::Keyval.from_name(key.split('+').last.capitalize)
      [keyval, state]
    end
  end
end

