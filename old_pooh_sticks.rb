begin
  require_relative "../ffi-gosu/lib/gosu"
rescue LoadError
  require "gosu"
end

class PoohSticks
  class Window < Gosu::Window
    Splash = Struct.new(:x, :y, :size)
    def initialize
      super(800, 600, false)

      @water_color = 0xff_222299
      @splash_color = 0xff_2222dd
      @ground_color = 0xff_336622 # 0xff_773322
      @path_color = 0xff_996666
      @bridge_color = 0xff_999999

      @water_width = 256
      @path_height = 96
      @bridge_width = 264
      @bridge_height = 104
      @splash_size = 48

      @list = []
    end

    def draw
      Gosu.draw_rect(0, 0, width, height, @ground_color)
      Gosu.draw_rect(0, height / 2 - @path_height / 2, width, @path_height, @path_color)
      Gosu.draw_rect(width / 2 - @water_width / 2, 0, @water_width, height, @water_color)

      Gosu.clip_to(width / 2 - @water_width / 2, 0, @water_width, height) do
        @list.each do |s|
          s.y += 1
          Gosu.draw_rect(s.x, s.y, s.size, s.size, @splash_color)
        end
      end

      Gosu.draw_rect(width / 2 - @bridge_width / 2, height / 2 - @bridge_height / 2, @bridge_width, @bridge_height, @bridge_color)
    end

    def update

      return unless rand < 0.01
      @list << Splash.new(rand((width / 2 - @water_width / 2)...(width / 2 + @water_width / 2)), -@splash_size, rand((@splash_size * 0.25)..@splash_size))
    end

    def button_down(id)
      case id
      when Gosu::MS_LEFT
        @list << Splash.new(mouse_x, mouse_y, rand((@splash_size * 0.25)..@splash_size))
      when Gosu::KB_F11
        if fullscreen?
          self.width  = 800
          self.height = 600
          self.fullscreen = false
        else
          self.width = Gosu.screen_width(self)
          self.height = Gosu.screen_height(self)
          self.fullscreen = true
        end
      end
    end
  end
end

PoohSticks::Window.new.show