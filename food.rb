require_relative 'constants'

module SnakeRuby
  class Food 
    COLOR = 'red'
    attr_reader :body

    def initialize(x,y)
      @body = Rect.new(x,y,BOX_SIZE,BOX_SIZE)
    end

    def draw(on_surface)
      on_surface.draw_box_s @body.topleft, @body.bottomright, COLOR
    end

    def move(x,y)
      @body.topleft = [x,y]
    end
  end
end
