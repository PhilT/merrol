module Merrol
  module CommandDispatcher
    def load_commands
      @help = Conf.load 'commands'
      @commands = {}
      @help.each do |name, category|
        category.each do |command, detail|
          @commands[detail['key']] = [command, detail['help']]
        end
      end
    end

    def handle key
      if @commands[key]
        self.send(@commands[key].first)
        true
      else
        false
      end
    end
  end
end

