require 'spec_helper'

describe Gtk::Window do
  it 'sets an icon' do
    window = Gtk::Window.new
    window.should_receive(:set_icon).with /..\/..\/path/
    window.icon = 'path'
  end
end

