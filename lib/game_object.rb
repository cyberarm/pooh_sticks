class PoohSticks
  class GameObject
    include CyberarmEngine::Common

    attr_reader :options
    attr_accessor :position, :velocity, :image, :angle, :color, :factor_x, :factor_y

    def initialize(options = {})
      @options = options

      @position = CyberarmEngine::Vector.new
      @velocity = CyberarmEngine::Vector.new

      @center_x = 0.5
      @center_y = 0.5

      @factor_x = 1.0
      @factor_y = 1.0

      @angle = 0

      @color = Gosu::Color::WHITE

      setup
    end

    def setup
    end

    def draw
      @image.draw_rot(
        @position.x, @position.y, @position.z,
        @angle, @center_x, @center_y, @factor_x, @factor_y,
        @color)
    end

    def update
    end

    def button_down(id)
    end

    def button_up(id)
    end

    def canvas_width
      window.current_state.canvas_width
    end

    def canvas_height
      window.current_state.canvas_height
    end
  end
end