require 'spec_helper'

describe Shortcut do
  def self.event modifiers, key
    e = Gdk::EventKey.new(Gdk::Event::KEY_PRESS)
    e.state = modifiers ? modifiers : e.state
    e.keyval = key
    e
  end

  class Gdk::EventKey
    def inspect
      modifiers = (state.control_mask? ? 1 : 0) |
        (state.mod1_mask? ? 2 : 0) |
        (state.shift_mask? ? 4 : 0)
      "#<Gdk::EventKey with state: #{modifiers}, keyval: #{keyval}, keycode: #{hardware_keycode}>"
    end

    def == other
      inspect == other.inspect
    end
  end

  S_KEY = Gdk::Keyval::GDK_S
  CTRL_KEY = Gdk::Window::CONTROL_MASK
  ALT_KEY = Gdk::Window::MOD1_MASK
  SHIFT_KEY = Gdk::Window::SHIFT_MASK

  @keys_events = {
    'CTRL' => event(nil, Gdk::Keyval::GDK_Control_L),
    'ESC' => event(nil, Gdk::Keyval::GDK_Escape),
    'ALT+ENTER' => event(ALT_KEY, Gdk::Keyval::GDK_Return),
    'CTRL+S' => event(CTRL_KEY, S_KEY),
    'CTRL+TAB' => event(CTRL_KEY, Gdk::Keyval::GDK_Tab),
    'CTRL+SHIFT+S' => event(CTRL_KEY | SHIFT_KEY, S_KEY),
    'CTRL+ALT+SHIFT+S' => event(CTRL_KEY | ALT_KEY | SHIFT_KEY, S_KEY)
  }.each do |key, event|
    it "returns #{key} from a #{event.inspect}" do
      Shortcut.from(event).should == key
    end

    it "returns #{event.inspect} from #{key}" do
      Shortcut.to_event(key).should == event
    end
  end

end

