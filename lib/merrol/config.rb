module Merrol
  class Conf
    def self.load filename
      YAML.load File.open(File.join(File.dirname(__FILE__), "../../config/#{filename}.yml"))
    end
  end
end

