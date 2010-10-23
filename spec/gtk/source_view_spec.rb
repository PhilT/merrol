require 'spec_helper'

describe Gtk::SourceView do
  before(:each) do
    @view = Gtk::SourceView.new
  end

  it 'sets font' do
    mock_font = mock Pango::FontDescription
    Pango::FontDescription.should_receive(:new).with('a font').and_return mock_font
    @view.should_receive(:modify_font).with mock_font
    @view.font = 'a font'
  end

  it 'sets theme' do
    mock_scheme = mock(Gtk::SourceStyleScheme)
    mock_style_manager = mock(Gtk::SourceStyleSchemeManager)
    Gtk::SourceStyleSchemeManager.stub(:new).and_return mock_style_manager
    mock_style_manager.should_receive(:prepend_search_path).with /path\/to/
    mock_style_manager.should_receive(:get_scheme).with('theme').and_return mock_scheme
    @view.stub :buffer
    @view.theme = 'path/to/theme'
    @view.theme.should == mock_scheme
  end

  it 'sets highlight_brackets' do
    @view.highlight_matching_brackets = true
    @view.highlight_brackets.should be_true
  end

  describe '#scroll_to_cursor' do
    it 'moves visible area to cursor' do
      mock_mark = Gtk::SourceMark
      mock_buffer = mock Gtk::SourceBuffer, :selection_bound => mock_mark
      @view.stub(:buffer).and_return mock_buffer
      @view.should_receive(:scroll_mark_onscreen).with(mock_mark)
      @view.scroll_to_cursor
    end
  end
end

