class EasyAI 
	attr_accessor :piece
	
	def initialize(piece)
		@piece = piece
	end

	def choose_move(game)
		piece_location = best_move(game)
		game.make_move(piece_location, @piece)
		ConsoleIO.print_message("Computer places " + @piece + " on " + piece_location.to_s)
	end
	
	def best_move(game)
		game.game_board.valid_moves.each do |move|
			if has_ttt(game, move, @piece) 
				return move
			end
		end
		return game.game_board.valid_moves.sample #random if no tic-tac-toe next.
	end

	def has_ttt(game, move, piece) 
		new_game = game.clone
		new_game.after_clone
		new_game.make_move(move,piece)
		TTTRules.has_winner_eval(new_game.game_board)
	end
end
