class PoohSticks
  class Window < CyberarmEngine::Window
    def setup
      self.caption = "Pooh Sticks"

      push_state(Game)
    end
  end
end