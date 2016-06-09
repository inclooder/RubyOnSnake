require_relative 'abstract_drawer'
require_relative '../config'

module SnakeRuby::Graphics
  class FoodDrawer < AbstractDrawer
    def draw surface, game_object
      body = game_object.body
      surface.draw_box_s body.topleft, body.bottomright, SnakeRuby::Config.food_color
    end

    def can_draw? game_object
      game_object.kind_of? SnakeRuby::Food
    end
  end
end
