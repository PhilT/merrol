module Gooy
  class Widget
    attr_reader :object

    def initialize object, name
      @object = object
      @object.name = name
    end

    def add widget
      object.add widget.object
    end
  end
end

