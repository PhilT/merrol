module Gooy
  describe Window do
    subject { Window.new 'window' }
    before { $main_quit_called = false }
    after { subject.object.destroy }

    it { subject.object.must_be_instance_of Gtk::Window }

    it 'quits' do
      subject.close
      $main_quit_called.must_equal true
    end

    it 'sets the icon for the window' do
      FakeFS.deactivate!
      icon_svg = 'lib/merrol/images/merrol.svg'
      subject.icon icon_svg
      subject.object.icon.must_be_instance_of Gdk::Pixbuf
    end

    it 'shows window and all children' do
      subject.show
      subject.object.must_be :visible?
    end

    it 'sets the title' do
      subject.title 'title'
      subject.object.title.must_equal 'title'
    end

    it 'block called when delete_event fired' do
      closing = false
      subject.when_closed { closing = true }
      subject.object.signal_emit('delete_event', Gdk::EventAny.new(Gdk::Event::DELETE))
      closing.must_equal true
    end

    describe 'when_pressed' do
      before do
        @pressed = false
        subject.when_pressed('CTRL+Q') { @pressed = true }
      end

      it 'block called when key pressed' do
        subject.object.signal_emit('key_press_event', Shortcut.to_event('CTRL+Q'))
        @pressed.must_equal true
      end

      it 'block not called when key does not match' do
        subject.object.signal_emit('key_press_event', Shortcut.to_event('CTRL+W'))
        @pressed.must_equal false
      end
    end
  end
end

