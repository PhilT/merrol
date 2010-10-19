module Merrol
  class Shortcut
    def from object
      if object.is_a?(Gdk::EventKey)
        from_event object
      else

      end
    end

    def from_event event
      unmodified_keyval = Gdk::Keymap.default.lookup_key(e.hardware_keycode, 0, 0)
      shortcut = Gdk::Keyval.to_name(unmodified_keyval).upcase
      shortcut.gsub!(/(_L|_R)$/, '')

      if !%w(CTRL ALT SHIFT).include? shortcut
        keys = []
        keys << "CTRL" if e.state.control_mask?
        keys << "ALT" if e.state.mod1_mask?
        keys << "SHIFT" if e.state.shift_mask?
        keys << shortcut
        shortcut = keys.join('+')
      end
      shortcut
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

def to_event key
  event = Gdk::EventKey.new(Gdk::Event::KEY_PRESS)
  event.state |= Gdk::Window::CONTROL_MASK if key =~ /CTRL+/
  event.state |= Gdk::Window::MOD1_MASK if key =~ /ALT+/
  event.state |= Gdk::Window::SHIFT_MASK if key =~ /SHIFT+/
  event.keyval = Gdk::Keyval.from_name(key.split('+').last)
  entry = Gdk::Keymap.default.get_entries_for_keyval(event.keyval).first
  event.hardware_keycode = entry[0]
  event
end

  end
end

