require "./lib/player"

class MediumAI < Player
	def initialize(piece)
		super(piece)
	end

	def choose_move(game)
		piece_location = best_move(game)
		game.make_move(piece_location, @piece)
		game.io.print_message("Computer places " + @piece + " on " + piece_location.to_s)
	end

	# If we have a tic-tac-toe, take it. Then, if computer WILL make a tic-tac-toe, take it.
	def best_move(game)
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
