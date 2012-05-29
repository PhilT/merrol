module Gooy
  class Row < Container
    def initialize name
      super Gtk::HBox.new, name
    end
  end
end

