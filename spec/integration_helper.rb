require 'spec_helper'

def line y
  window = Curses.stdscr
  old_x = window.curx
  old_y = window.cury

  width = window.maxx
  buffer = ''

  for x in 0..width
    window.setpos y, x
    buffer << window.inch
  end
  window.setpos old_y, old_x
  buffer.gsub(/                 ( )+/, '[multiple spaces]')
end

MiniTest::Spec.add_teardown_hook do
  Curses.close_screen
end

