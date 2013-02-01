module Merrol
  class Screen
    def initialize
      Curses.init_screen
      Curses.ESCDELAY = 50
      Curses.start_color
      Curses.raw
      Curses.noecho
      Curses.curs_set 1
      @main = Curses::Window.new(Curses.lines, Curses.cols, 0, 0)
    end

    def clear

    end
  end
end
