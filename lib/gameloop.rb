require_relative "ttt_rules"
require_relative "ttt_game"
require_relative "ttt_game_creator"
require_relative "ui/ttt_ui"
require_relative "ui/consoleio"
require_relative "ui/input_processor"
require_relative "ui/input_checker"

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
