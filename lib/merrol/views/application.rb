module Merrol
  class Application
    def initialize window
      @window = window
      @window.icon File.join(APP_PATH, 'merrol', 'images', 'merrol.svg')
      @window.title "Merrol v#{VERSION} - #{PROJECT_PATH}"
      @window.when_closed { @window.close }
      @window.when_pressed('CTRL+Q') { @window.close }

      row = Gooy::Row.new '0'
      scroll_view = Gooy::ScrollView.new 'scrollable'

      text_view = Gooy::TextView.new 'source'
      text_view.theme_path File.join(APP_PATH, 'merrol', 'config', 'styles')
      text_view.theme 'railscastsimp'

      scroll_view.add(text_view)
      row.add scroll_view
      @window.add row

      @window.show
    end
  end
end

