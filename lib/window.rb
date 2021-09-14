class PoohSticks
  class Window < CyberarmEngine::Window
    attr_reader :song

    def setup
      self.caption = "Pooh Sticks"

      @song = get_song("#{GAME_ROOT_PATH}/media/songs/distortion_by_centurion_of_war_oga.ogg")
      @song.volume = 0.25
      @song.play(true)

      push_state(Game)
    end
  end
end