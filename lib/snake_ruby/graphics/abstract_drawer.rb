module SnakeRuby::Graphics
  class AbstractDrawer
    def draw surface, game_object
      raise NotImplementedError
    end

    def can_draw? game_object_class
      raise NotImplementedError
    end
  end
end
