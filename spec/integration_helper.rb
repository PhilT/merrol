require 'spec_helper'

require 'support/base'
require 'support/actions'
require 'support/expectations'

module Gooy
  class Window
    def close
      $closing = true
    end
  end
end

