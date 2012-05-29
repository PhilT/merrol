module Gooy
  class ScrollView < Widget
    def initialize name
      super Gtk::ScrolledWindow.new, name
      object.set_policy(Gtk::POLICY_AUTOMATIC, Gtk::POLICY_AUTOMATIC)
    end
  end
end

