require_relative 'config'

module SnakeRuby
  class Food 
    attr_reader :body

    def initialize(x,y)
      @body = Rect.new(x,y, Config.box_size, Config.box_size)
    end

    def move(x,y)
      @body.topleft = [x,y]
    end
  end
end
