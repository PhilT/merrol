require 'spec_helper'

describe Gtk::ListView do
  before(:each) do
    @list_view = Gtk::ListView.new
    @mock_iter = mock Gtk::TreeIter
    @mock_selection = mock Gtk::TreeSelection, :selected => nil, :select_iter => nil
    @mock_list_store = mock Gtk::ListStore, :append => nil, :set_value => nil, :prepend => @mock_iter
    @mock_list_store.stub(:iter_first).and_return @mock_iter
    @list_view.stub(:selection).and_return @mock_selection
    @list_view.stub(:model).and_return @mock_list_store
  end

  it 'headers are not visible' do
    @list_view.should_not be_headers_visible
  end

  it 'has one column' do
    @list_view.columns.size.should == 1
  end

  describe '#prepend' do
    it 'adds row to the start of the list' do
      @mock_list_store.should_receive :prepend
      @mock_list_store.should_receive(:set_value).with(@mock_iter, 0, 'Item 1')
      @list_view.prepend 'Item 1'
    end

    it 'selects item' do
      @mock_selection.should_receive(:select_iter).with @mock_iter
      @list_view.prepend 'Item 1'
    end
  end

  describe '#list=' do
    before(:each) do
      @list_view.stub!(:model=)
      @list_view.stub!(:model).and_return @mock_list_store
      Gtk::ListStore.stub!(:new).and_return @mock_list_store
    end

    it 'insert a number of rows' do
      @mock_list_store.should_receive(:append).twice.and_return @mock_iter
      @mock_list_store.should_receive(:set_value).with(@mock_iter, 0, 'Item 1')
      @mock_list_store.should_receive(:set_value).with(@mock_iter, 0, 'Item 2')
      @list_view.list = ['Item 1', 'Item 2']
    end

    it 'selects first row' do
      @mock_selection.should_receive(:select_iter).with @mock_iter
      @list_view.list = ['Item 1']
    end

    it 'does not select first row if none set' do
      @list_view.should_not_receive(:selection)
      @list_view.list = []
    end
  end

  describe '#next' do
    it 'selects the next row' do
      mock_selection = mock Gtk::TreeSelection, :selected => @mock_iter
      @mock_iter.should_receive :next!
      mock_selection.should_receive(:select_iter).with @mock_iter
      @list_view.stub(:selection).and_return mock_selection
      @list_view.next
    end

    context 'when no row selected' do
      it 'what should happen?'
    end
  end

  describe '#selected' do
    before(:each) do
    end

    it 'retrieves the text of the selected row' do
      @list_view.stub(:selection).and_return @mock_selection
      @mock_selection.stub(:selected).and_return @mock_iter
      @mock_iter.stub(:[]).with(0).and_return 'selected row'
      @list_view.selected.should == 'selected row'
    end

    it 'does not fail when nothing selected' do
      @list_view.stub(:selection).and_return @mock_selection
      @list_view.selected.should be_nil
    end
  end

  describe '#selected_to_top' do
    it 'moves the selected row to the top of the list' do
      @list_view.stub(:selection).and_return @mock_selection
      selected_mock_iter = mock Gtk::TreeIter
      @mock_selection.stub(:selected).and_return selected_mock_iter
      @list_view.stub(:model).and_return @mock_list_store
      @mock_list_store.should_receive(:move_before).with(selected_mock_iter, @mock_iter)
      @list_view.selected_to_top
    end
  end

  describe '#empty?' do
    it 'empty when no rows' do
      @mock_list_store.stub(:iter_first).and_return nil
      @list_view.should be_empty
    end

    it 'not empty when at least one row' do
      @mock_list_store.stub(:iter_first).and_return @mock_iter
      @list_view.should_not be_empty
    end
  end
end

