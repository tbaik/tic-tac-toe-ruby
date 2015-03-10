require_relative "ttt_ai"

class HardAI < TTTAI
	def initialize(piece)
		super(piece)
	end

	def choose_move(game)
		if (game.game_board.valid_moves.size) < 10 
			piece_location = best_move(game)
		else
			piece_location = medium_move(game)
		end
	end

	def best_move(game)
		bestMove = -99
		bestScore = -1
		game.game_board.valid_moves.each do |move|
			score = get_score(game, move, @piece) 
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
		has_winner = game.rules.has_winner(game.game_board)
		if !has_winner
			return 1 if game.game_board.num_pieces == game.game_board.board.size 
			score = 0
			piece_to_place = ""
			if game.is_player_turn
				score = 999
				piece_to_place = game.human_player.piece
			else
				score = -999
				piece_to_place = @piece
			end

			game.game_board.valid_moves.each do |move|
				new_score = get_score(game, move, piece_to_place)
				if ((game.is_player_turn && new_score < score) || (!game.is_player_turn && new_score > score))
					score = new_score
				end
			end
			return score
		else 
			return game.is_player_turn ? 2 : 0
		end
	end

	def get_score(game, move, piece) 
		new_game = game.clone
		deep_copy_clone(new_game)
		new_game.make_move(move)
		minimax(new_game)
	end
	
  def medium_move(game)
    piece = @piece
    2.times do
      game.game_board.valid_moves.each do |move|
        if has_next_ttt(game, move, piece) 
          return move
        end
      end
      piece = game.rules.opposite_piece(@piece)
    end
    return game.game_board.pick_random_move 
  end
end
