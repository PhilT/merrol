module Merrol
  class Commands
    def initialize(window)
      @accel_group = Gtk::AccelGroup.new
      window.add_accel_group @accel_group
      load_commands
    end

    def register category, command, &block
      @accel_group.connect "<#{APP_NAME}>/#{category}/#{command}", &block
    end

private

    def load_commands
      @help = YAML.load_config 'commands'
      @commands = {}
      @help.each do |name, category|
        category.each do |command, detail|
          @commands[detail['key']] = [command, detail['help']]
          keyval, modifiers = to_keyval(detail['key'])
          Gtk::AccelMap.add_entry("<#{APP_NAME}>/#{name}/#{command}", keyval, modifiers)
        end
      end
    end

    def to_keyval key
      state = 0
      state |= Gdk::Window::CONTROL_MASK if key =~ /CTRL+/
      state |= Gdk::Window::MOD1_MASK if key =~ /ALT+/
      state |= Gdk::Window::SHIFT_MASK if key =~ /SHIFT+/
      keyval = Gdk::Keyval.from_name(key.split('+').last)
      [keyval, state]
    end
  end


end

