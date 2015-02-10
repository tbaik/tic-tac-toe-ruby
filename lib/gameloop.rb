require "./lib/ttt_rules"
require "./lib/ttt_game"

module GameLoop
	def self.run_ttt_loop
		while(true)
			hp = TTTRules.create_human_player
			cp = TTTRules.create_computer_player(hp.piece)	
			gb = TTTRules.create_game_board
			game = TTTGame.new(gb,hp,cp)
			game.play
		end
	end
end
GameLoop.run_ttt_loop
