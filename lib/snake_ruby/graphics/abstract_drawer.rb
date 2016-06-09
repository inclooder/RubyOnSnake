module SnakeRuby::Graphics
  class AbstractDrawer
    def draw surface, game_object
      raise 'Abstract method call!'
    end

    def can_draw? game_object_class
      raise 'Abstract method call!'
    end
  end
end
