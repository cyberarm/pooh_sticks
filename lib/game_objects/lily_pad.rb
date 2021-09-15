class PoohSticks
  class GameObject
    class LilyPad < PoohSticks::GameObject
      def setup
        @image = get_image("#{GAME_ROOT_PATH}/media/lily_pad.png")
        @shadow_color.alpha = 10

        @position.x = @options[:x]
        @position.y = @options[:y]
        @position.z = ZOrder::RIVER

        @angle = @options[:angle] || rand(359)

        scalar = SecureRandom.random_number(0.75..1.25)
        @factor_x = scalar
        @factor_y = scalar
      end

      def draw
        @image.draw_rot(
          @position.x + 4, @position.y + 4, @position.z,
          @angle, @center_x, @center_y, @factor_x, @factor_y,
          @shadow_color
        )

        super
      end

      def update
        super

        @position.y += 50 * window.dt

        window.current_state.game_objects.delete(self) if @position.y > canvas_height + @image.height
      end
    end
  end
end