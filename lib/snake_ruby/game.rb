require 'rubygame'
require_relative 'food'
require_relative 'snake'
require_relative 'graphics/object_drawer_locator'
require_relative 'sound_controller'

include Rubygame

module SnakeRuby
  class Game
    def initialize
      SoundController.init
      @screen = Screen.new [Config.screen_width, Config.screen_height], 0, [HWSURFACE, DOUBLEBUF]

      @queue = EventQueue.new
      @clock = Clock.new
      @clock.target_framerate = Config.framerate
      sr = @screen.make_rect
      @snake = Snake.new(sr.centerx, sr.centery, Config.snake_initial_length, :up, sr)
      @food = []
      @object_drawer_locator = Graphics::ObjectDrawerLocator.new @screen
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
          SoundController.play_eat
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
      @food.each do |f|
        @object_drawer_locator.draw f
      end
      @object_drawer_locator.draw @snake
      @screen.update
    end
  end
end
