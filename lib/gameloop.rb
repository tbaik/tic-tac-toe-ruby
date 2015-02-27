require "./lib/ttt_rules"
require "./lib/ttt_game"
require "./lib/ttt_game_creator"
require "./lib/ui/ttt_ui"
require "./lib/ui/consoleio"
require "./lib/ui/input_processor"
require "./lib/ui/input_checker"

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
