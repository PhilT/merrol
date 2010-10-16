module Merrol
  class Controller
    include Observable

    def initialize commands, views
      @commands = commands
      @views = views

      @commands.register(self)
    end

    def method_missing(meth, *args, &block)
      method = meth.to_s
      if method =~ /_view$/
        @views[method.gsub(/_view$/, '').to_sym]
      else
        super
      end
    end

    def name
      self.class.to_s.demodulize.underscore.gsub(/_controller$/, '').to_sym
    end
  end
end

