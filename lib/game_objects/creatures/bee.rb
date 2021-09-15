class PoohSticks
  class GameObject
    class Bee < PoohSticks::GameObject
      def setup
        @image = get_image("#{GAME_ROOT_PATH}/media/bee.png")

        @position.x = @options[:x]
        @position.y = @options[:y]
        @position.z = ZOrder::RIVER

        @angle = @options[:angle] || rand(359)

        @targets = window.current_state.flowers.shuffle

        @target_position = @targets.first / window_scale
      end

      def draw
        super

        @image.draw_rot(
          @position.x, @position.y + @image.height * 2, @position.z,
          @angle, @center_x, @center_y, @factor_x, @factor_y,
          @shadow_color
        )
      end

      def update
        super

        normal = (@target_position - @position).normalized
        @position += normal * (100 * window.dt)

        @position.z = ZOrder::CREATURES

        if @position.distance(@target_position) < 8
          @targets.rotate!
          @target_position = @targets.first / window_scale
        end

        @angle = Gosu.angle(@position.x, @position.y, @target_position.x, @target_position.y)
      end

      def window_scale
        window.current_state.scale
      end
    end
  end
end
