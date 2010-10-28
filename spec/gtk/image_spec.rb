require 'spec_helper'

describe Gtk::Image do
  subject { Gtk::Image.new }

  it '#file= sets relative filename' do
    subject.should_receive(:set_file).with /merrol\/image/
    subject.file = 'image'
  end
end

