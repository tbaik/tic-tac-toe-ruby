require "./lib/ttt_ai"

class MediumAI < TTTAI
	def initialize(piece)
		super(piece)
	end

	def choose_move(game)
		piece_location = best_move(game)
	end

	# If we have a tic-tac-toe, take it. Then, if computer WILL make a tic-tac-toe, take it.
	def best_move(game)
		game.game_board.valid_moves.each do |move|
			if has_next_ttt(game, move, @piece) 
				return move
			end
		end
		
		game.game_board.valid_moves.each do |move|
			if has_next_ttt(game, move, TTTRules.opposite_piece(@piece)) 
				return move
			end
		end

		return game.game_board.valid_moves.sample #random if no tic-tac-toe next.
	end
end
