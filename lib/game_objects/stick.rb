class PoohSticks
  class GameObject
    class Stick < PoohSticks::GameObject
      def setup
        @drag = 0.95
        @image = get_image("#{GAME_ROOT_PATH}/media/stick.png")
        @river_shadow_color = Gosu::Color.rgba(0, 0, 0, 10)

        @position.x = @options[:x]
        @position.y = @options[:y]
        @position.z = ZOrder::STICK

        @angle = @options[:angle] || rand(359)
      end

      def draw
        if @position.z == ZOrder::STICK_IN_FLIGHT
          @image.draw_rot(
            @position.x, @position.y + (@image.height * (@velocity.y / PoohSticks::Creature::Bear::THROW_SPEED)), @position.z,
            @angle, @center_x, @center_y, @factor_x, @factor_y,
            @shadow_color
          )
        else
          @image.draw_rot(
            @position.x + 4, @position.y + 4, @position.z,
            @angle, @center_x, @center_y, @factor_x, @factor_y,
            @river_shadow_color
          )
        end

        super
      end

      def update
        super

        zorder = @position.z

        @velocity *= @drag
        @velocity = CyberarmEngine::Vector.new if @velocity.sum.abs < 20
        @position += @velocity * window.dt

        @velocity.y += 150 / 60.0 if @position.z == ZOrder::RIVER

        @position.z = zorder

        if @position.z == ZOrder::STICK_IN_FLIGHT && @velocity.sum.round < 200
          if @position.x.between?(canvas_width / 2 - 250, canvas_width / 2 + 250)
            @position.z = ZOrder::RIVER
          else
            @position.z = ZOrder::STICK
          end
        end

        if @position.y > canvas_height + @image.height
          window.current_state.game_objects.delete(self)
        end
      end
    end
  end
end