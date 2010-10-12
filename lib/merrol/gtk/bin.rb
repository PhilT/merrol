module Gtk
  class Bin
    attr_reader :container

    def container= widget
      @container = eval(widget).new
      self.add(@container)
    end
  end
end

