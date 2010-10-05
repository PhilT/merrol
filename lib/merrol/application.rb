module Merrol
  class Application
    def self.initialize!
      new.do_stuff
    end

    def do_stuff
      puts 'init!'
    end
  end
end

