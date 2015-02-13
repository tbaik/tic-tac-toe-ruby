require "./lib/ttt_rules"
require "./lib/player"

class HardAI < Player
	def initialize(piece)
		super(piece)
	end

	def choose_move(game)
		if (game.game_board.board.size - game.game_board.num_pieces) < 11 
			# Computer does minimax algorithm, chooses best move or piece location.	
			piece_location = best_move(game)
		else
		   	# This AI is Unbeatable for 3x3 but is beatable for 4x4 and 5x5 
			# since it will take too long to do a perfect evaluation on the board. 
			piece_location = medium_move(game)
		end
			game.make_move(piece_location, @piece)
			game.io.print_message("Computer places " + @piece + " on " + piece_location.to_s)
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
		deep_copy_clone(new_game)
		new_game.make_move(move, piece)
		minimax(new_game)
	end
	
	# If we have a tic-tac-toe, take it. Then, if computer WILL make a tic-tac-toe, take it.
	def medium_move(game)
		game.game_board.valid_moves.each do |move|
			if has_ttt(game, move, @piece) 
				return move
			end
		end
		
		game.game_board.valid_moves.each do |move|
			if has_ttt(game, move, TTTRules.opposite_piece(@piece)) 
				return move
			end
		end

		return game.game_board.valid_moves.sample #random if no tic-tac-toe next.
	end

	def has_ttt(game, move, piece) 
		new_game = game.clone
		deep_copy_clone(new_game)
		new_game.make_move(move,piece)
		TTTRules.has_winner_eval(new_game.game_board)
	end

	def deep_copy_clone(new_game)
		new_game.human_player = new_game.human_player.clone
		new_game.game_board = new_game.game_board.clone
		new_game.game_board.board = new_game.game_board.board.clone
		new_game.game_board.valid_moves = new_game.game_board.valid_moves.clone
		new_game
	end
end
