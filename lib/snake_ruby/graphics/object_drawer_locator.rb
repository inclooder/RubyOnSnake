require_relative 'snake_drawer'
require_relative 'food_drawer'

module SnakeRuby::Graphics
  class ObjectDrawerLocator
    def initialize surface
      @surface = surface
      @drawers = [
        FoodDrawer.new,
        SnakeDrawer.new
      ]
    end

    def draw game_object
      @drawers.each do |drawer|
        if drawer.can_draw? game_object
          drawer.draw @surface, game_object
          break
        end
      end
    end
  end
end
