require 'spec_helper'

describe Gtk::ListView do
  before(:each) do
    @list_view = Gtk::ListView.new
  end

  it 'headers are not visible' do
    @list_view.should_not be_headers_visible
  end

  it 'has one column' do
    @list_view.columns.size.should == 1
  end

  it 'sets a list of strings' do
    mock_tree_iter = mock Gtk::TreeIter
    mock_list_store = mock Gtk::ListStore
    @list_view.stub!(:model=)
    @list_view.stub!(:model).and_return mock_list_store
    Gtk::ListStore.stub!(:new).and_return mock_list_store
    mock_list_store.should_receive(:append).twice.and_return mock_tree_iter
    mock_list_store.should_receive(:set_value).with(mock_tree_iter, 0, 'Item 1')
    mock_list_store.should_receive(:set_value).with(mock_tree_iter, 0, 'Item 2')
    @list_view.list = ['Item 1', 'Item 2']
  end

  it 'can add a string' do

  end

  it 'can remove a string' do

  end

  it 'selects a specified string' do

  end

  it 'selects the next string in the list' do

  end

  it 'selects the previous string in the list' do

  end
end

