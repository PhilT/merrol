module Merrol
  class EditController < Controller
    def switch buffer
      edit_view.buffer = buffer
    end

  end
end

