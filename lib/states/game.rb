class PoohSticks
  class Game < CyberarmEngine::GameState
    def setup
      @background = get_image("#{GAME_ROOT_PATH}/media/background.png")
      @bear = get_image("#{GAME_ROOT_PATH}/media/bear.png")

      @x = 0
      @y = 0
      @speed = 200

      @scale = [window.width.to_f / @background.width, window.height.to_f / @background.height].min
    end

    def draw
      Gosu.scale(@scale, @scale) do
        @background.draw(0, 0, 0)
        @bear.draw(@x, @y, 0)
      end
    end

    def update
      @x -= @speed * window.dt if Gosu.button_down?(Gosu::KB_A)
      @x += @speed * window.dt if Gosu.button_down?(Gosu::KB_D)
      @y -= @speed * window.dt if Gosu.button_down?(Gosu::KB_W)
      @y += @speed * window.dt if Gosu.button_down?(Gosu::KB_S)
    end

    def button_up(id)
      window.close if id == Gosu::KB_ESCAPE
    end
  end
end