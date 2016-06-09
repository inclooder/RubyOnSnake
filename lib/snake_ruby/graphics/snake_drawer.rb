require_relative 'abstract_drawer'
require_relative '../config'

module SnakeRuby::Graphics
  class SnakeDrawer < AbstractDrawer
    def draw surface, snake_game_object
      parts = snake_game_object.parts
      parts[1..-1].each do |part|
        surface.draw_box_s part.topleft, part.bottomright, SnakeRuby::Config.snake_color
      end
      head = snake_game_object.head
      surface.draw_box_s head.topleft, head.bottomright, SnakeRuby::Config.snake_head_color
    end

    def can_draw? game_object
      game_object.kind_of? SnakeRuby::Snake
    end
  end
end
