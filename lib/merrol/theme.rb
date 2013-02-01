module Merrol
  class Theme < OpenStruct
    def initialize theme_file
      super nil
      @yaml = YAML.load File.read(theme_file)
      self.keyword = 0xF92672
    end

  private
    def set_color index, color
      r = (((color & 0xff0000) >> 16) / 255.0 * 1000).to_i
      g = (((color & 0x00ff00) >> 8) / 255.0 * 1000).to_i
      b = ((color & 0x0000ff) / 255.0 * 1000).to_i
      Curses.init_color(index, r, g, b)
    end


  end
end
