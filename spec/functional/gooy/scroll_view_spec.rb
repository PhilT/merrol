module Gooy
  describe ScrollView do
    subject { ScrollView.new 'scroller' }
    it { subject.object.must_be_instance_of Gtk::ScrolledWindow }
  end
end

