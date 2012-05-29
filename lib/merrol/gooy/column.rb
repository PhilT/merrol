module Gooy
  class Column < Container
    def initialize name
      super Gtk::VBox.new, name
    end
  end
end

