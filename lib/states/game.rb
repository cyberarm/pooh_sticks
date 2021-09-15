class PoohSticks
  class Game < CyberarmEngine::GameState
    attr_reader :flowers, :scale

    def setup
      @background = get_image("#{GAME_ROOT_PATH}/media/background.png")
      @trail = get_image("#{GAME_ROOT_PATH}/media/trail.png")

      @birds = get_sample("#{GAME_ROOT_PATH}/media/sfx/bird_chirping_sounds_by_synocpika_oga.wav")

      @scale = [window.width.to_f / @background.width, window.height.to_f / @background.height].min

      @flowers = [
        CyberarmEngine::Vector.new(44,   50).freeze,
        CyberarmEngine::Vector.new(101, 112).freeze,
        CyberarmEngine::Vector.new(169,  97).freeze,
        CyberarmEngine::Vector.new(91,  243).freeze,
        CyberarmEngine::Vector.new(163, 263).freeze,
        CyberarmEngine::Vector.new(170, 309).freeze,
        CyberarmEngine::Vector.new(110, 309).freeze,
        CyberarmEngine::Vector.new(437, 112).freeze,
        CyberarmEngine::Vector.new(434,  50).freeze,
        CyberarmEngine::Vector.new(558, 115).freeze,
        CyberarmEngine::Vector.new(503, 132).freeze,
        CyberarmEngine::Vector.new(507, 260).freeze,
        CyberarmEngine::Vector.new(433, 336).freeze,
        CyberarmEngine::Vector.new(620, 242).freeze,
      ].freeze

      add_game_object(Creature::Bear.new(attach_controls: true))

      add_game_object(GameObject::Tree.new(x: 300, y: 40))
      add_game_object(GameObject::Tree.new(x: 1450, y: 25))

      add_game_object(GameObject::Bee.new(x: -32, y: -32))
      add_game_object(GameObject::Bee.new(x: -32, y: -32))
      add_game_object(GameObject::Bee.new(x: window.width + 32, y: window.height + 32))
      add_game_object(GameObject::Bee.new(x: window.width + 32, y: window.height + 32))

      @last_lilypad_spawn = Gosu.milliseconds
      @lilypad_spawn_interval = 3_500
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

        # @flowers.each do |flower|
        #   Gosu.draw_circle(flower.x / @scale, flower.y / @scale, 16, 16)
        # end
      end
    end

    def update
      @scale = [window.width.to_f / @background.width, window.height.to_f / @background.height].min

      spawn_lilypad

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

    def spawn_lilypad
      return unless Gosu.milliseconds - @last_lilypad_spawn >= @lilypad_spawn_interval

      @last_lilypad_spawn = Gosu.milliseconds

      add_game_object(GameObject::LilyPad.new(x: canvas_width / 2 + SecureRandom.random_number(-220..220), y: -32))
    end
  end
end