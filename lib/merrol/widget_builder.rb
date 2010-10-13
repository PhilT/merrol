module Merrol
  class WidgetBuilder
    def self.build *view_names
      widgets = {}
      view_names.each do |view_name|
        yaml = YAML.load(view_name)
        widget = nil
        add_to = nil
        pack = {:expand => false, :fill => false, :padding => 0}
        yaml['layout'].merge(yaml['options'] || {}).each do |key, value|
          if key == 'type'
            widget = eval('Gtk::' + value).new
          elsif value.is_a?(Hash)
            widget.send("#{key}=", constants_from(value))
          elsif key == 'add_to'
            add_to = widgets[value]
          elsif %w(expand fill padding).include?(key)
            pack[key.to_sym] = value
          else
            widget.send("#{key}=", value)
          end
        end

        if add_to
          container = add_to.container if add_to.respond_to?(:container)
          container ||=  add_to
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

  private

    def self.constants_from value
      type = value['type']
      value = value['value']
      value = [value] unless value.is_a?(Array)

      eval(value.map{ |v| ['Gtk', type, v].compact.join('::') }.join(' | '))
    end
  end
end

