module Gooy
  describe Container do
    subject { Container.new Gtk::HBox.new, 'container' }

    it 'adds a child' do
      child = Column.new 'column'
      subject.add child
      subject.object.children.first.must_equal child.object
    end
  end
end

