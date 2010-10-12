require 'spec_helper'

describe Gtk::SourceView do
  before(:each) do
    @view = Gtk::SourceView.new
  end

  it 'sets language' do
    mock_language = mock(Gtk::SourceLanguage)
    mock_language_manager = mock Gtk::SourceLanguageManager, :get_language => mock_language
    Gtk::SourceLanguageManager.stub!(:new).and_return mock_language_manager
    mock_buffer = mock(Gtk::SourceBuffer)
    mock_buffer.should_receive(:language=).with mock_language
    @view.stub!(:buffer).and_return mock_buffer
    @view.language = 'some language'
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
    mock_style_manager.should_receive(:prepend_search_path).with /..\/..\/path\/to/
    mock_style_manager.should_receive(:get_scheme).with('theme').and_return mock_scheme
    mock_buffer = mock(Gtk::SourceBuffer)
    mock_buffer.should_receive(:style_scheme=).with mock_scheme
    @view.stub!(:buffer).and_return mock_buffer

    @view.theme = 'path/to/theme'
  end
end

