module Merrol
  module CommandDispatcher
    def load_commands
      @help = Conf.load 'commands'
      @commands = {}
      @help.each do |name, category|
        category.each do |command, detail|
          @commands[detail['key']] = [command, detail['help']]
        end
      end
    end

    def handle e
      keys = []
      keys << "CTRL" if e.state.control_mask?
      keys << "ALT" if e.state.mod1_mask?
      keys << "SHIFT" if e.state.shift_mask?
      unmodified_keyval = Gdk::Keymap.default.lookup_key(e.hardware_keycode, 0, 0)
      keys << Gdk::Keyval.to_name(unmodified_keyval).upcase
      key = keys.join('+')
      if @commands[key]
        self.send(@commands[key].first)
        true
      else
        false
      end
    end
  end
end

