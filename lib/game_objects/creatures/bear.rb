class PoohSticks
  class Creature
    class Bear < PoohSticks::GameObject::Creature
      def setup
        @image = get_image("#{GAME_ROOT_PATH}/media/bear.png")
        @shadow = get_image("#{GAME_ROOT_PATH}/media/shadow.png")

        @position.z = ZOrder::CREATURES
        @center_y = 1.0

        @speed = 200
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
      end
    end
  end
end
