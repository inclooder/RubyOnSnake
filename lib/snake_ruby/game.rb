require 'rubygems'
require 'rubygame'
require_relative 'food'
require_relative 'snake'

include Rubygame

module SnakeRuby
  class Game
    def initialize
      @screen = Screen.new [640, 480], 0, [HWSURFACE, DOUBLEBUF]

      @queue = EventQueue.new
      @clock = Clock.new
      @clock.target_framerate = 30
      sr = @screen.make_rect
      @snake = Snake.new(sr.centerx, sr.centery, Config.snake_initial_length, :up, sr)
      @food = []
      spawn_food
    end

    def draw_background
      @screen.fill Config.background_color
    end

    def spawn_food
      @food.push Food.new rand((@screen.w / Config.box_size)) * Config.box_size, rand((@screen.h/Config.box_size)) * Config.box_size
    end

    def food_collision
      @food.each do |f|
        if f.body.contain? @snake.head
          @snake.grow += 1
          spawn_food
          @food.delete(f)
          break
        end
      end
    end


    def run
      loop do
        update
        draw
        @clock.tick
      end
    end

    def handle_keys ev
      @snake.handle_movement ev
    end

    def update
      food_collision
      @snake.act
      st = "Ruby on Snake [score:#{@snake.length}]"
      st += " Game Over" unless @snake.allive
      @screen.title = st
      @queue.each do |ev|
        case ev
        when QuitEvent
          Rubygame.quit
          exit
        when KeyDownEvent
          handle_keys ev
        end
      end
    end

    def draw
      draw_background
      @food.each {|f| f.draw @screen}
      @snake.draw @screen
      @screen.update
    end
  end
end
