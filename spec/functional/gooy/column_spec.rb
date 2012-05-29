module Gooy
  describe Column do
    subject { Column.new 'column' }
    it { subject.must_be_kind_of Container }
    it { subject.object.must_be_instance_of Gtk::VBox }
  end
end

