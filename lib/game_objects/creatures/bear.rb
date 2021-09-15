class PoohSticks
  class Creature
    class Bear < PoohSticks::GameObject::Creature
      THROW_SPEED = 500

      def setup
        @image = get_image("#{GAME_ROOT_PATH}/media/bear.png")
        @shadow = get_image("#{GAME_ROOT_PATH}/media/shadow.png")

        @position.z = ZOrder::CREATURES
        @center_y = 1.0

        @speed = 200

        @managed_sticks = []
      end

      def draw
        @shadow.draw_rot(@position.x, @position.y, @position.z)

        super
      end

      def update
        super

        @last_position = @position.clone

        @position.x -= @speed * window.dt if Gosu.button_down?(Gosu::KB_A) || Gosu.button_down?(Gosu::KB_LEFT)
        @position.x += @speed * window.dt if Gosu.button_down?(Gosu::KB_D) || Gosu.button_down?(Gosu::KB_RIGHT)
        @position.y -= @speed * window.dt if Gosu.button_down?(Gosu::KB_W) || Gosu.button_down?(Gosu::KB_UP)
        @position.y += @speed * window.dt if Gosu.button_down?(Gosu::KB_S) || Gosu.button_down?(Gosu::KB_DOWN)

        @position.x = @image.width / 2 if @position.x < @image.width / 2
        @position.x = canvas_width - @image.width / 2 if @position.x > canvas_width - @image.width / 2

        @position.y = @image.height if @position.y < @image.height
        @position.y = canvas_height - @shadow.height / 3 if @position.y > canvas_height - @shadow.height / 3

        # A stick with a zorder of ZOrder::RIVER means it's in the river and can't be picked up
        sticks = window.current_state.game_objects.select do |o|
          o.is_a?(PoohSticks::GameObject::Stick) && o.position.z == ZOrder::STICK
        end

        sticks.each do |stick|
          if @position.distance(stick.position) < 32
            window.current_state.game_objects.delete(stick)
            @managed_sticks << stick
          end
        end
      end

      def button_down(id)
        if id == Gosu::KB_SPACE
          throw_stick
        end
      end

      def throw_stick
        return if @managed_sticks.count.zero?

        stick = @managed_sticks.pop
        window.current_state.add_game_object(stick)

        stick.position.x = @position.x
        stick.position.y = @position.y - 32
        stick.position.z = ZOrder::STICK_IN_FLIGHT
        stick.velocity.y = THROW_SPEED
      end
    end
  end
end
