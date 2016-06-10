module SnakeRuby
  class Board
    def initialize(width, height)
      @width = width
      @height = height
      @matrix = Array.new(width * height)
    end

    def set_at(x, y, obj)
      return unless (0..width).include? x
      return unless (0..height).include? y
      @matrix[x * y] = obj
    end

    def get_at(x, y)
      @matrix[x * y]
    end

    def empty_at?(x, y)
      get_at(x, y).nil?
    end
end
