module Merrol
  class Shortcut
    def self.from event
      shortcut = Gdk::Keyval.to_name(event.keyval).upcase
      shortcut = shortcut.gsub(/(_L|_R)$/, '').gsub('CONTROL', 'CTRL').gsub('ESCAPE', 'ESC').gsub('RETURN', 'ENTER')

      if !%w(CTRL ALT SHIFT).include? shortcut
        keys = []
        keys << "CTRL" if event.state.control_mask?
        keys << "ALT" if event.state.mod1_mask?
        keys << "SHIFT" if event.state.shift_mask?
        keys << shortcut
        shortcut = keys.join('+')
      end
      shortcut
    end

    def self.to_event key, release = nil
      event = Gdk::EventKey.new(release ? Gdk::Event::KEY_RELEASE : Gdk::Event::KEY_PRESS)
      key = key.gsub(/ESC/, 'ESCAPE').gsub(/ENTER/, 'RETURN')

      if %w(CTRL ALT SHIFT).include? key
        key = key.gsub('CTRL', 'CONTROL').capitalize + '_L'
      else
        event.state |= Gdk::Window::CONTROL_MASK if key =~ /CTRL+/
        event.state |= Gdk::Window::MOD1_MASK if key =~ /ALT+/
        event.state |= Gdk::Window::SHIFT_MASK if key =~ /SHIFT+/
        key = key.split('+').last.capitalize
      end
      event.keyval = Gdk::Keyval.from_name(key)
      event
    end
  end
end

