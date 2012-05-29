module Gooy
  describe Row do
    subject { Row.new 'row' }
    it { subject.must_be_kind_of Container }
    it { subject.object.must_be_instance_of Gtk::HBox }
  end
end

