module Gooy
  describe Widget do
    it 'sets the internal gtk widget and name' do
      mock = MiniTest::Mock.new
      mock.expect(:name=, nil, ['widget'])
      subject = Widget.new mock, 'widget'
      mock.verify
    end

    it 'adds other Gooy widgets' do
      child = TextView.new nil
      subject = Widget.new Gtk::Window.new, 'widget'
      subject.add child
      subject.object.children.first.must_equal child.object
    end
  end
end

