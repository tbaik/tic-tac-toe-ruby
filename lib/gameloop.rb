require "./lib/ttt_rules"
require "./lib/ttt_game"

module GameLoop
	def self.run_ttt_loop
		while(true)
			game = TTTRules.read_or_new_game 
			game.play
		end
	end
end
GameLoop.run_ttt_loop
