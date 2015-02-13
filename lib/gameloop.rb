require "./lib/ttt_rules"
require "./lib/ttt_game"
require "./lib/ttt_game_creator"

module GameLoop
	def self.run_ttt_loop
		while(true)
			game = TTTGameCreator.read_or_new_game 
			game.play
		end
	end
end
GameLoop.run_ttt_loop
