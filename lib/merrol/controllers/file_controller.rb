module Merrol
  class FileController < Controller
    def switch
      file_list_view.show
      file_list_view.next
      edit_view.buffer = @source_models[file_list_view.selected]
      self.handler_id = main_view.signal_connect('key_release_event') do |widget, event|
        if event.keyval == Gdk::Keyval::GDK_Control_L
          file_list_view.hide
          main_view.signal_handler_disconnect(handler_id)
          edit_view.scroll_to_cursor
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
      model.signal_connect('modified_changed') do
        if model.modified?
          file_status_view.file = 'data/images/modified.svg'
        else
          file_status_view.file = 'data/images/saved.svg'
        end
      end
      edit_view.buffer = model
    end

    def load_all paths
      @source_models = {}
      paths.each do |path|
        load path
      end
    end

  private
    attr_accessor :handler_id

  end
end

