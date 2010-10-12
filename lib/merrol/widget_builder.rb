module Merrol
  class WidgetBuilder
    def self.build *view_names
      widgets = {}
      view_names.each do |view_name|
        yaml = YAML.load(File.open(File.join(File.dirname(__FILE__), "views/#{view_name}.yml")))
        widget = nil
        pack = {:add_to => nil, :expand => false, :fill => false, :padding => 0}
        yaml['layout'].merge(yaml['options'] || {}).each do |key, value|
          if key == 'type'
            widget = eval('Gtk::' + value).new
          elsif value.is_a?(Hash)
            widget.send("#{key}=", eval(['Gtk', value['type'], value['value']].compact.join('::')))
          elsif key == 'add_to'
            pack[:add_to] = widgets[value]
          elsif %w(expand fill padding).include?(key)
            pack[key.to_sym] = value
          else
            widget.send("#{key}=", value)
          end
        end
        if pack[:add_to]
          container = (pack[:add_to].container || pack[:add_to])
          if container.is_a?(Gtk::Bin)
            container.add(widget)
          else
            container.pack_start(widget, pack[:expand], pack[:fill], pack[:padding])
          end
        end
        widgets[view_name] = widget
      end
      widgets
    end
  end
end

