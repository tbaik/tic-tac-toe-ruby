require "./lib/ttt_rules"

class HardAI
	attr_accessor :piece
	def initialize(piece)
		@piece = piece
	end

	def choose_move(game)
		# Computer does minimax algorithm, chooses best move or piece location.
		piece_location = best_move(game)
		game.make_move(piece_location, @piece)
		ConsoleIO.print_message("Computer places " + @piece + " on " + piece_location.to_s)
	end

	# Compute and compare which move will give us the best score.
	def best_move(game)
		bestMove = -1
		bestScore = -1
		game.game_board.valid_moves.each do |move|
			score = get_score(game, move, @piece) # pass in true since it's now human_player's turn.
			if score > bestScore
				bestScore = score
				bestMove = move
			end
		end
		return bestMove
	end

	# Tries to lower the human human_player's score as much as possible and 
	# Get the highest score possible for the computer. 
	# We do this by simulating gameplay through all possible moves and comparing the results
	# taking into consideration whose turn it is. 
	def minimax(game)
		has_winner = TTTRules.has_winner(game.game_board)
		# while still in play
		if !has_winner
			return 1 if game.game_board.num_pieces == 9 #tie game
			score = 0
			piece_to_place = ""
			if game.human_player.is_player_turn
				score = 999
				piece_to_place = game.human_player.piece
			else
				score = -999
				piece_to_place = @piece
			end

			game.game_board.valid_moves.each do |move|
				new_score = get_score(game, move, piece_to_place)
				if ((game.human_player.is_player_turn && new_score < score) || (!game.human_player.is_player_turn && new_score > score))
					score = new_score
				end
			end
			return score
		else # we have a winner
			return game.human_player.is_player_turn ? 2 : 0
		end
	end

	def get_score(game, move, piece) 
		new_game = game.clone
		new_game.after_clone
		new_game.make_move(move, piece)
		minimax(new_game)
	end
end

