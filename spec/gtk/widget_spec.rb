require 'spec_helper'

describe Gtk::Widget do
  it 'sets the font' do
    mock_font = mock Pango::FontDescription
    Pango::FontDescription.stub!(:new).with('font').and_return mock_font

    window = Gtk::Window.new
    window.should_receive(:modify_font).with mock_font
    window.font = 'font'
  end

  describe 'initially_hidden' do
    before(:each) do
      @window = Gtk::Window.new
    end

    it 'ignores first show call when initially hidden' do
      @window.initially_hidden = true
      @window.show_all
      @window.should_not be_visible
    end

    it 'shows when not initially hidden' do
      @window.show_all
      @window.should be_visible
    end

    it 'is made visible on subsequent calls to show' do
      @window.initially_hidden = true
      @window.show
      @window.should be_visible
    end
  end

end

