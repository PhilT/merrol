module Merrol
  class FileController < Controller
    def switch

    end

    def save
      edit_view.buffer.save
    end

    def load_all paths
      @source_models = paths.map { |path| SourceModel.new(path) }
      edit_view.buffer = @source_models.first
    end
  end
end

