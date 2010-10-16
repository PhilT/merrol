module Merrol
  class FileController < Controller
    def switch

    end

    def save
      edit_view.buffer.save
    end

    def load_all paths
      @source_models = paths.map { |path| SourceModel.new(path) }
      @source_models.each do |model|
        model.modified = false
        model.signal_connect('modified_changed') do
          if model.modified?
            file_status_view.file = 'data/images/modified.svg'
          else
            file_status_view.file = 'data/images/saved.svg'
          end
        end
      end
      edit_view.buffer = @source_models.first
    end
  end
end

