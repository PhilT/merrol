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
      selection.select_iter(self.model.iter_first) if items.any?
    end

    def selected
      selection.selected[0] if selection.selected
    end

    def next
      iter = selection.selected
      iter.next!
      selection.select_iter iter
    end

    def selected_to_top
      self.model.move_before selection.selected, self.model.iter_first
    end
  end
end

