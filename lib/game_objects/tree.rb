class PoohSticks
  class GameObject
    class Tree < PoohSticks::GameObject
      def setup
        @image = get_image("#{GAME_ROOT_PATH}/media/tree.png")

        @position.x = @options[:x] + @image.width / 2
        @position.y = @options[:y] + @image.height
        @position.z = ZOrder::TREE_INFRONT

        @managed_sticks = []

        @trunk_size = 64 / 3.0

        @center_y = 1.0

        @stick_drop_interval = 15_000
        @last_drop_at = -@stick_drop_interval
      end

      def draw
        super

        @managed_sticks.each(&:draw)
      end

      def update
        super

        bear = window.current_state.game_objects.find { |o| o.is_a?(PoohSticks::Creature::Bear) }

        @position.z = bear.position.y - @position.y > @trunk_size ? ZOrder::TREE_BEHIND : ZOrder::TREE_INFRONT

        spawn_stick
        managed_sticks_update
      end

      def spawn_stick
        if Gosu.milliseconds - @last_drop_at >= @stick_drop_interval
          @last_drop_at = Gosu.milliseconds

          return unless window.current_state.game_objects.select { |s| s.is_a?(PoohSticks::GameObject::Stick) }.count < 7

          @managed_sticks << PoohSticks::GameObject::Stick.new(
            x: @position.x + SecureRandom.random_number(-75..75),
            y: @position.y - @image.height / 2 + SecureRandom.random_number(64),
            random_drop_distance: SecureRandom.random_number(32)
          )
        end
      end

      def managed_sticks_update
        vector = CyberarmEngine::Vector.new(@position.x, @position.y - @image.height / 2)

        @managed_sticks.each do |stick|
          stick.position.y += 200 * window.dt

          next unless stick.position.distance(vector) >= @image.height / 2 + stick.options[:random_drop_distance]

          @managed_sticks.delete(stick)
          stick.position.z = ZOrder::DECORATIONS
          window.current_state.add_game_object(stick)
        end
      end
    end
  end
end
