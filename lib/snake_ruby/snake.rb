require 'rubygems'
require 'rubygame'
include Rubygame

require_relative 'config'

module SnakeRuby
  class Snake
    attr_accessor :direction, :grow, :parts
    attr_reader :land_rect, :allive

    INVALID_DIRECTION_CHANGES = {
      :right => :left, 
      :left => :right, 
      :up => :down, 
      :down => :up
    }.freeze

    KEY_TO_DIRECTION = {
      K_UP => :up, 
      K_DOWN => :down, 
      K_RIGHT => :right, 
      K_LEFT => :left
    }.freeze

    def move_by_direction(rect)
      case @direction
      when :up then rect.y -= Config.box_size
      when :left then rect.x -= Config.box_size 
      when :down then rect.y += Config.box_size
      when :right then rect.x += Config.box_size
      end
      rect.clone
    end

    def length
      @parts.size
    end

    def initialize(x,y,length,direction, land_rect)
      @grow = 0
      @allive = true
      @direction = direction
      @land_rect = land_rect
      @parts = []
      start = Rect.new(x,y,Config.box_size,Config.box_size)
      length.times do
        start = move_by_direction(start)
        @parts.unshift start
      end
    end

    def act
      calc_collision
      if @allive
        if @grow == 0
          @parts.pop
        else
          @grow -= 1
        end
        new_part = move_by_direction(@parts.first)
        @parts.unshift new_part 
      end
    end

    def head
      head = @parts.first
    end

    def draw on_surface
      @parts[1..-1].each do |part|
        on_surface.draw_box_s part.topleft, part.bottomright, Config.snake_color
      end
      on_surface.draw_box_s head.topleft, head.bottomright, Config.snake_head_color
    end

    def handle_movement ev
      if ev.key == K_G
        @grow += 1
      end
      new_dir = KEY_TO_DIRECTION[ev.key]

      unless INVALID_DIRECTION_CHANGES[@direction] == new_dir
        @direction = new_dir
      end
    end

    def calc_collision
      m = move_by_direction(@parts.first.clone)

      unless @land_rect.contain? m
        @allive = false
      end

      @parts.each do |part|
        if part.contain? m
          @allive = false
          break
        end
      end
    end
  end
end
