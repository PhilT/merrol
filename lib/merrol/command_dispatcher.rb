module CommandDispatcher
  module ClassMethods
  end

  module InstanceMethods
    def load_commands
      @help = YAML.load File.open(File.dirname(__FILE__) + '/config/commands.yml')
      @commands = {}
      @help.each do |name, category|
        category.each do |command, detail|
          @commands[detail['key']] = command
        end
      end
    end

    def handle key
      if @commands[key]
        self.send(@commands[key])
        true
      else
        false
      end
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end

end

