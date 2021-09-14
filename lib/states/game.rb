class PoohSticks
  class Game < CyberarmEngine::GameState
    def setup
      @background = get_image("#{GAME_ROOT_PATH}/media/background.png")
      @trail = get_image("#{GAME_ROOT_PATH}/media/trail.png")
      @bear = get_image("#{GAME_ROOT_PATH}/media/bear.png")
      @stick = get_image("#{GAME_ROOT_PATH}/media/stick.png")
      @tree = get_image("#{GAME_ROOT_PATH}/media/tree.png")
      @shadow = get_image("#{GAME_ROOT_PATH}/media/shadow.png")

      @song = get_song("#{GAME_ROOT_PATH}/media/songs/distortion_by_centurion_of_war_oga.ogg")
      @song.volume = 0.25
      @song.play(true)

      @birds = get_sample("#{GAME_ROOT_PATH}/media/sfx/bird_chirping_sounds_by_synocpika_oga.wav")

      @x = 0
      @y = 0
      @speed = 200

      @scale = [window.width.to_f / @background.width, window.height.to_f / @background.height].min

      @stick_pos = -@stick.height
    end

    def canvas_width
      window.width / @scale
    end

    def canvas_height
      window.height / @scale
    end

    def draw
      Gosu.scale(@scale, @scale) do
        @background.draw(0, 0, 0)

        @stick.draw(canvas_width / 2, @stick_pos, 0)

        @trail.draw(0, canvas_height / 2.0 - @trail.height / 2, 0)
        @shadow.draw_rot(@x + @bear.width / 2, @y + @bear.height, 0)
        @bear.draw(@x, @y, 0)

        @tree.draw(300, 40, 0)
        @tree.draw(1450, 25, 0)

        @stick.draw(@x + 16, @y + 128 + 16, 0)
      end
    end

    def update
      @scale = [window.width.to_f / @background.width, window.height.to_f / @background.height].min

      @x -= @speed * window.dt if Gosu.button_down?(Gosu::KB_A) || Gosu.button_down?(Gosu::KB_LEFT)
      @x += @speed * window.dt if Gosu.button_down?(Gosu::KB_D) || Gosu.button_down?(Gosu::KB_RIGHT)
      @y -= @speed * window.dt if Gosu.button_down?(Gosu::KB_W) || Gosu.button_down?(Gosu::KB_UP)
      @y += @speed * window.dt if Gosu.button_down?(Gosu::KB_S) || Gosu.button_down?(Gosu::KB_DOWN)

      @stick_pos += @speed * window.dt
      @stick_pos = -@stick.height if @stick_pos > canvas_height
    end

    def button_down(id)
      @birds.play(0.25, 0.75) if id == Gosu::KB_SPACE
    end

    def button_up(id)
      window.close if id == Gosu::KB_ESCAPE
    end
  end
end