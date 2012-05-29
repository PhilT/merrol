module Gooy
  class Container < Widget
    def add widget
      object.pack_start widget.object, true, true
    end
  end
end

