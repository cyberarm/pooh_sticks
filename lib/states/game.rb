class PoohSticks
  class Game < CyberarmEngine::GameState
    def setup
      add_game_object(Creature::Bear.new(attach_controls: true))

      add_game_object(GameObject::Tree.new(x: 300, y: 40))
      add_game_object(GameObject::Tree.new(x: 1450, y: 25))

      @background = get_image("#{GAME_ROOT_PATH}/media/background.png")
      @trail = get_image("#{GAME_ROOT_PATH}/media/trail.png")

      @birds = get_sample("#{GAME_ROOT_PATH}/media/sfx/bird_chirping_sounds_by_synocpika_oga.wav")

      @scale = [window.width.to_f / @background.width, window.height.to_f / @background.height].min
    end

    def canvas_width
      window.width / @scale
    end

    def canvas_height
      window.height / @scale
    end

    def draw
      Gosu.scale(@scale, @scale) do
        @background.draw(0, 0, ZOrder::BACKGROUND)
        @trail.draw(0, canvas_height / 2.0 - @trail.height / 2, ZOrder::TRAIL)

        super
      end
    end

    def update
      @scale = [window.width.to_f / @background.width, window.height.to_f / @background.height].min

      super
    end

    def button_down(id)
      super

      @birds.play(0.25, 0.75) if id == Gosu::KB_SPACE
    end

    def button_up(id)
      super

      window.close if id == Gosu::KB_ESCAPE
    end
  end
end