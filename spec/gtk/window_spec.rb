require 'spec_helper'

describe Gtk::Window do
  subject {Gtk::Window.new}

  describe '#icon' do
    it 'is assigned' do
      subject.should_receive(:set_icon).with /merrol\/path/
      subject.icon = 'path'
    end
  end

  describe '#default_position=' do
    it 'is assigned' do
      subject.should_receive(:move).with 1, 2
      subject.default_position = '1, 2'
    end
  end

  describe '#default_size=' do
    it 'is assigned' do
      subject.should_receive(:set_default_size).with 1, 2
      subject.default_size = '1, 2'
    end
  end

end

