module Merrol
  class Application
    include CommandDispatcher

    def self.start_from working_dir, arguments
      Application.new working_dir, arguments
    end

protected
    def build_widgets_from *view_names
      view_names.each do |view_name|
        yaml = YAML.load(File.open(File.join(File.dirname(__FILE__), "views/#{view_name}.yml")))
        widget = nil
        pack = {:add_to => nil, :expand => false, :fill => false, :padding => 0}
        puts yaml
        yaml['layout'].merge(yaml['options'] || {}).each do |key, value|
          if key == 'type'
            widget = eval('Gtk::' + value).new
          elsif value.is_a?(Hash)
            widget.send("#{key}=", eval("Gtk::#{value['type']}::#{value['value']}"))
          elsif key == 'add_to'
            pack[:add_to] = @widgets[value]
          elsif %w(expand fill padding).include?(key)
            pack[key.to_sym] = value
          else
            widget.send("#{key}=", value)
          end
        end
        (pack[:add_to].container || pack[:add_to]).pack_start(widget, pack[:expand], pack[:fill], pack[:padding]) if pack[:add_to]
        @widgets[view_name] = widget
      end
    end

    def initialize working_dir, arguments
      @widgets = {}
      load_commands

      build_widgets_from 'main', 'status_bar', 'file_path', 'scroll_bars', 'editor'
      load_files(filepaths, view)

      signal_connect('destroy') do
        save_state
        false
      end

      signal_connect('key_press_event') do |w, e|
        keys = []
        keys << "CTRL" if e.state.control_mask?
        keys << "ALT" if e.state.mod1_mask?
        keys << "SHIFT" if e.state.shift_mask?
        unmodified_keyval = Gdk::Keymap.default.lookup_key(e.hardware_keycode, 0, 0)
        keys << Gdk::Keyval.to_name(unmodified_keyval).upcase
        shortcut = keys.join('+')
        handle(shortcut)
        false
      end

      main.show_all
    end

    def complete

    end

    def quit
      destroy
    end

    def save_state
      Gtk.main_quit
    end

    def load_files filepaths, view
      if filepaths.first
        view.buffer.text = File.read(filepaths.first)
        @fileinfo.text = filepaths.first
      end
    end
  end
end

