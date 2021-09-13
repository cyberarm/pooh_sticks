begin
  require_relative "../cyberarm_engine/lib/cyberarm_engine"
rescue LoadError
  require "cyberarm_engine"
end

GAME_ROOT_PATH = File.expand_path(".", __dir__)

require_relative "lib/window"
require_relative "lib/states/game"

# PoohSticks::Window.new(width: Gosu.screen_width, height: Gosu.screen_height, fullscreen: true).show
PoohSticks::Window.new(width: Gosu.screen_width / 3, height: Gosu.screen_height / 3, fullscreen: false).show