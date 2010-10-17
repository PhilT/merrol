module Gtk
  class ListView < TreeView
    def initialize
      super
      self.headers_visible = false
      self.append_column(Gtk::TreeViewColumn.new('Name', Gtk::CellRendererText.new, "text" => 0))
    end

    def list= items
      self.model = Gtk::ListStore.new(String)
      items.each do |item|
        iter = self.model.append
        self.model.set_value(iter, 0, item)
      end
    end

    def prepend item
    end

    def append item

    end

    def remove item

    end

    def selected

    end
  end
end

