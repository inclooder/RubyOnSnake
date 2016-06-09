require_relative 'config'

module SnakeRuby
  class Food 
    attr_reader :body

    def initialize(x,y)
      @body = Rect.new(x,y, Config.box_size, Config.box_size)
    end

    def draw(on_surface)
      on_surface.draw_box_s @body.topleft, @body.bottomright, Config.food_color
    end

    def move(x,y)
      @body.topleft = [x,y]
    end
  end
end
