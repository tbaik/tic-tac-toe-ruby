require "player/ai/ttt_ai"

class EasyAI < TTTAI
	
	def initialize(piece)
		super(piece)
	end

	def choose_move(game)
    game.game_board.valid_moves.each do |move|
			if has_next_ttt(game, move, @piece) 
				return move
			end
		end
		return game.game_board.pick_random_move
	end
end
