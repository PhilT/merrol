module Merrol
  class EditController < Controller
    def switch buffer
      edit_view.buffer = buffer
    end

    def select_all
      edit_view.select_all(true)
    end

    def select_none
      edit_view.select_all(false)
    end

    def undo
      edit_view.undo
    end

    def redo
      edit_view.redo
    end
  end
end

