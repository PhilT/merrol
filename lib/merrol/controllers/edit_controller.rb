module Merrol
  class EditController < Controller
    def initialize commands, views
      super commands, views
    end

    def switch buffer
      edit_view.buffer = buffer
    end

    def save
    end

    def load_all paths
      source_models = paths.map { |path| SourceModel.new(path) }
      edit_view.buffer = source_models.first
    end
  end
end

