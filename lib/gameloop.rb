require "./lib/gameboard"
require "./lib/player"
require "./lib/consoleio"

module GameLoop

	def self.run_ttt_loop
		while(true)
			player = GameLoop.initial_input
			gb = GameBoard.new(player)
			gb.print_board
			has_winner = play_until_finish(gb)
			ConsoleIO.winner_output(has_winner, gb.num_pieces, gb.player)
		end
	end

	def self.initial_input
		while(true)
			turn = ConsoleIO.start_game_input
			player = create_player(turn)
			return player if !player.nil?
		end
	end

	def self.run_player_loop(gb)
		while(true)
			piece_location = ConsoleIO.next_piece_input
			if gb.is_valid_move?(piece_location)
				gb.place_piece(piece_location.to_i, gb.player.piece) # make a move
				ConsoleIO.place_player_piece(gb.player.piece, piece_location)
				break;
			else
				ConsoleIO.invalid_move
			end
		end
	end

	def self.play_until_finish(gb)
		has_winner = false
		while(!has_winner && gb.num_pieces < 9)
			if gb.player.is_player_turn == true
				run_player_loop(gb)
			else
				# Computer does minimax algorithm, chooses best move or piece location.
				piece_location = best_move(gb)
				gb.place_piece(piece_location, gb.player.opponent_piece)
				ConsoleIO.place_computer_piece(gb.player.opponent_piece, (piece_location).to_s)
			end
			gb.print_board
			has_winner = gb.has_winner
		end
		return has_winner
	end

	# Compute and compare which move will give us the best score.
	def self.best_move(game_board)
		bestMove = -1
		bestScore = -1
		game_board.valid_moves.each do |move|
			new_board = game_board.clone
			new_board.after_clone
			new_board.place_piece(move, new_board.player.opponent_piece)

			score = minimax(new_board) # pass in true since it's now player's turn.

			if score > bestScore
				bestScore = score
				bestMove = move
			end
		end
		return bestMove
	end

	# Tries to lower the human player's score as much as possible and 
	# Get the highest score possible for the computer. 
	# We do this by simulating gameplay through all possible moves and comparing the results
	# taking into consideration whose turn it is. 
	def self.minimax(game_board)
		has_winner = game_board.has_winner
		# while still in play
		if !has_winner
			if game_board.num_pieces == 9 #tie game
				return 1
			end
			score = 0
			piece_to_place = ""
			if game_board.player.is_player_turn
				score = 999
				piece_to_place = game_board.player.piece
			else
				score = -999
				piece_to_place = game_board.player.opponent_piece
			end

			game_board.valid_moves.each do |move|
				new_board = game_board.clone
				new_board.after_clone
				new_board.place_piece(move, piece_to_place) #switch this out every time.
				
				new_score = minimax(new_board)
				if ((game_board.player.is_player_turn && new_score < score) || (!game_board.player.is_player_turn && new_score > score))
					score = new_score
				end
			end
			return score
		else # we have a winner
			if game_board.player.is_player_turn # Computer won
				return 2
			else
				return 0 # Player won
			end
		end
	end

	def self.create_player(turn)
		if turn == "1"
			Player.new("X", true)
		elsif turn == "2"
			Player.new("O", false)
		elsif turn == "3"
			exit
		else
			nil
		end
	end
end