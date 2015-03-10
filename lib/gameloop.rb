$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))
require "ttt_game_creator"
require "ui/ttt_ui"
require "ui/consoleio"
require "ui/input_processor"
require "ui/input_checker"

module GameLoop
	def self.run_ttt_loop
		while(true)
      game_creator = TTTGameCreator.new(TTTUI.new(ConsoleIO, InputProcessor, InputChecker))
			game = game_creator.new_game 
			game.play
		end
	end
end
GameLoop.run_ttt_loop
