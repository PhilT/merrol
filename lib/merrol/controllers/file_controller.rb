module Merrol
  class FileController < Controller
    def switch

    end

    def save
      edit_view.buffer.save
    end

    def load path
      model = SourceModel.new(path)
      @source_models << model
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
      @source_models = []
      paths.each do |path|
        load path
      end
    end
  end
end

