module Merrol
  class StatusBarController < Controller
    def initialize view, file_status, file_path
      @view = view
      @file_status = file_status
      @file_path = file_path
    end

    def text= text
      @file_path.text = text
    end
  end
end

