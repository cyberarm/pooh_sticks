class PoohSticks
  class GameObject
    class Stick < PoohSticks::GameObject
      def setup
        @image = get_image("#{GAME_ROOT_PATH}/media/stick.png")

        @position.x = @options[:x]
        @position.y = @options[:y]
        @position.z = ZOrder::STICK

        @angle = @options[:angle] || rand(359)
      end
    end
  end
end