require 'rubygems'
require 'rubygame'
include Rubygame

module SnakeRuby
  class Snake
    COLOR = 'green'
    HEAD_COLOR = 'yellow'
    attr_accessor :direction, :grow, :parts
    attr_reader :land_rect, :allive


    def move_by_direction(rect)
      case @direction
      when :up then rect.y-= BOX_SIZE
      when :left then rect.x-= BOX_SIZE 
      when :down then rect.y+= BOX_SIZE
      when :right then rect.x+= BOX_SIZE
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
      start = Rect.new(x,y,BOX_SIZE,BOX_SIZE)
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
          @grow-=1
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
        on_surface.draw_box_s part.topleft, part.bottomright, COLOR
      end
      on_surface.draw_box_s head.topleft, head.bottomright, HEAD_COLOR
    end

    def handle_movement ev
      if ev.key == K_G
        @grow+=1
      end
      new_dir = {K_UP => :up, K_DOWN => :down, K_RIGHT => :right, K_LEFT => :left}[ev.key]

      unless {:right => :left, :left => :right, :up => :down, :down => :up}[new_dir] == @direction
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
