module Merrol
  class FileController < Controller
    def initialize commands, views
      super commands, views
      @source_models = {}
    end

    def switch
      return if file_list_view.empty?
      file_list_view.show if @second_switch
      @second_switch = true
      file_list_view.next
      edit_view.buffer = @source_models[file_list_view.selected]
      edit_view.scroll_to_cursor
      self.handler_id = main_view.signal_connect('key_release_event') do |widget, event|
        if event.keyval == Gdk::Keyval::GDK_Control_L
          @second_switch = false
          file_list_view.hide
          main_view.signal_handler_disconnect(handler_id)
          file_list_view.selected_to_top
          true
        else
          false
        end
      end
    end

    def save
      edit_view.buffer.save
    end

    def load path
      model = SourceModel.new(path)
      @source_models[path] = model
      model.style_scheme = edit_view.theme
      model.highlight_matching_brackets = edit_view.highlight_brackets
      model.modified = false
      model.place_cursor model.start_iter
      model.signal_connect('modified_changed') do
        if model.modified?
          file_status_view.file = 'data/images/modified.svg'
        else
          file_status_view.file = 'data/images/saved.svg'
        end
      end
      edit_view.buffer = model
      file_list_view.prepend path
    end

    def load_all paths
      paths.each do |path|
        load path
      end
    end

  private
    attr_accessor :handler_id

  end
end

