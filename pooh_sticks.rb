begin
  require_relative "../cyberarm_engine/lib/cyberarm_engine"
rescue LoadError
  require "cyberarm_engine"
end

require "securerandom"

GAME_ROOT_PATH = File.expand_path(".", __dir__)

require_relative "lib/zorder"
require_relative "lib/window"
require_relative "lib/states/game"
require_relative "lib/game_object"
require_relative "lib/game_objects/tree"
require_relative "lib/game_objects/stick"
require_relative "lib/game_objects/creature"
require_relative "lib/game_objects/creatures/bear"

# PoohSticks::Window.new(width: Gosu.screen_width, height: Gosu.screen_height, fullscreen: true).show
PoohSticks::Window.new(width: Gosu.screen_width / 3, height: Gosu.screen_height / 3, fullscreen: false).show