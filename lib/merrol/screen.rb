module Merrol
  class Screen
    def initialize
      Curses.init_screen
      Curses.ESCDELAY = 50
      Curses.start_color
      Curses.raw
      Curses.noecho
      Curses.curs_set 1
      @screen = Curses.stdscr
      @yaml = YAML.load File.read(theme_file)
    end

    def set_color index, color
      r = (((color & 0xff0000) >> 16) / 255.0 * 1000).to_i
      g = (((color & 0x00ff00) >> 8) / 255.0 * 1000).to_i
      b = ((color & 0x0000ff) / 255.0 * 1000).to_i
      Curses.init_color(index, r, g, b)
    end
  end
end
