
module SnakeRuby
  class Config
    def self.root_dir
      File.expand_path('../../../', __FILE__)
    end

    def self.sound_dir
      File.expand_path('sfx', data_dir)
    end

    def self.eat_sound
      File.expand_path('eat.wav', sound_dir)
    end

    def self.data_dir
      File.expand_path('data', root_dir)
    end

    def self.framerate
      30
    end
    
    def self.screen_width
      640
    end

    def self.screen_height
      480
    end

    def self.snake_initial_length
      10
    end

    def self.snake_color
      'green'
    end

    def self.snake_head_color
      'yellow'
    end

    def self.box_size
      10
    end

    def self.food_color
      'red'
    end

    def self.background_color
      'black'
    end
  end
end
