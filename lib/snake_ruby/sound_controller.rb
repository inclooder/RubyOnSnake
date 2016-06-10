require 'rubygame'

module SnakeRuby
  class SoundController
    def self.init
      Music.autoload_dirs  << Config.sound_dir
      @sounds = {}
    end

    def self.play_eat
      @sounds[Config.eat_sound] ||= Sound.load(Config.eat_sound)
      @sounds[Config.eat_sound].play
    end
  end
end
