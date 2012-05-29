module Gooy
  class Window < Widget
    def initialize name
      super Gtk::Window.new, name
    end

    def close
      Gtk.main_quit
    end

    def icon path
      object.icon = path
    end

    def show
      object.show_all
    end

    def title text
      object.title = text
    end

    def when_closed &block
      object.signal_connect('delete_event', &block)
    end

    def when_pressed key, &block
      object.signal_connect('key_press_event') do |w, e|
        yield if Shortcut.from(e) == key
      end
    end
  end
end

