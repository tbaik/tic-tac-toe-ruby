require "./lib/ttt_rules"
require "./lib/ttt_game"
require "./lib/setup/ttt_game_creator"
require "./lib/ttt_ui"
require "./lib/consoleio"

module GameLoop
	def self.run_ttt_loop
		while(true)
      game_creator = TTTGameCreator.new(TTTUI.new(ConsoleIO))
			game = game_creator.new_game 
			game.play
		end
	end
end
GameLoop.run_ttt_loop
