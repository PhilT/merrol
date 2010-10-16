module Merrol
  class EditorController < Controller
    def initialize view, status_bar, filepaths, commands
      @view = view
      @status_bar = status_bar
      @filepaths = filepaths
      load_files @filepaths
      commands.register 'file', 'save' do
        save
      end
    end

    def save
      File.open(@filepaths.first, 'w') {|f| f.write(@view.buffer.text) }
    end

  private
    def load_files filepaths
      filepath = filepaths.first
      if filepath
        @view.buffer.text = File.read(filepath) if File.exist?(filepath)
        @status_bar.text = filepath
      end
    end
  end
end

