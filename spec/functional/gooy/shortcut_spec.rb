module Gooy
  describe Shortcut do
    def self.build_events modifiers, key
      {
        :press => build_event(Gdk::Event::KEY_PRESS, modifiers, key),
        :release => build_event(Gdk::Event::KEY_RELEASE, modifiers, key)
      }
    end

    def self.build_event type, modifiers, key
      e = Gdk::EventKey.new(type)
      e.state = modifiers ? modifiers : e.state
      e.keyval = key
      e
    end

    class Gdk::EventKey
      def inspect
        modifiers = (state.control_mask? ? 1 : 0) |
          (state.mod1_mask? ? 2 : 0) |
          (state.shift_mask? ? 4 : 0)
        "#<Gdk::EventKey #{event_type.name} with state: #{modifiers}, keyval: #{keyval}, keycode: #{hardware_keycode}>"
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
      'CTRL' => build_events(nil, Gdk::Keyval::GDK_Control_L),
      'ESC' => build_events(nil, Gdk::Keyval::GDK_Escape),
      'ALT+ENTER' => build_events(ALT_KEY, Gdk::Keyval::GDK_Return),
      'CTRL+S' => build_events(CTRL_KEY, S_KEY),
      'CTRL+TAB' => build_events(CTRL_KEY, Gdk::Keyval::GDK_Tab),
      'CTRL+SHIFT+S' => build_events(CTRL_KEY | SHIFT_KEY, S_KEY),
      'CTRL+ALT+SHIFT+S' => build_events(CTRL_KEY | ALT_KEY | SHIFT_KEY, S_KEY)
    }.each do |key, event|
      it "returns #{key} from a key press event" do
        Shortcut.from(event[:press]).must_equal key
      end

      it "returns a key press event from #{key}" do
        Shortcut.to_event(key).must_equal event[:press]
      end

      it "returns a key release event from #{key}" do
        Shortcut.to_event(key, :release).must_equal event[:release]
      end
    end

  end
end

