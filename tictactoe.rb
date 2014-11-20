require "./gameboard"

# Compute and compare which move will give us the best score.
def best_move(game_board)
	bestMove = -1
	bestScore = -1
	game_board.valid_moves.each do |move|
		new_board = game_board.clone
		new_board.after_clone
		new_board.place_piece(move, COMPUTER)

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
def minimax(game_board)
	has_winner = game_board.has_winner
	# while still in play
	if !has_winner
		if game_board.num_pieces == 9 #tie game
			return 1
		end
		score = 0
		piece_to_place = ""
		if game_board.is_player_turn
			score = 999
			piece_to_place = PLAYER
		else
			score = -999
			piece_to_place = COMPUTER
		end

		game_board.valid_moves.each do |move|
			new_board = game_board.clone
			new_board.after_clone
			new_board.place_piece(move, piece_to_place) #switch this out every time.
			
			new_score = minimax(new_board)
			if ((game_board.is_player_turn && new_score < score) || (!game_board.is_player_turn && new_score > score))
				score = new_score
			end
		end
		return score
	else # we have a winner
		if game_board.is_player_turn # Computer won
			return 2
		else
			return 0 # Player won
		end
	end
end

puts "Hello! Let's play a game of tic-tac-toe against a computer!"
puts "Please type 1 to go First(X) or 2 to go Second(O)"
turn = gets
player_turn = true

if turn == "2\n"
	player_turn = false
	PLAYER = "O"
	COMPUTER = "X"
else
	PLAYER = "X"
	COMPUTER = "O"
end

gb = GameBoard.new(player_turn)
has_winner = false
gb.print_board

while(!has_winner && gb.num_pieces < 9)
	if player_turn == true
		while(true)
			puts "Here's the Game Board. Please type an empty piece location (1-9) to place a piece."
			piece_location = gets
			if gb.is_valid_move?(piece_location)
				gb.place_piece(piece_location.to_i - 1, PLAYER) # make a move
				puts "Player places " + PLAYER + " on " + piece_location
				player_turn = false # Now it's the computer's turn
				break;
			else
				puts "Invalid move. Try Again!"
			end
		end
	else
		# Computer does minimax algorithm, chooses best move or piece location.
		piece_location = best_move(gb)
		gb.place_piece(piece_location, COMPUTER)
		puts "Computer places " + COMPUTER + " on " + (piece_location + 1).to_s
		player_turn = true # Now it's the player's turn
	end
	gb.print_board
	has_winner = gb.has_winner
end

# We have a winner or a tie!
if (!has_winner && (gb.num_pieces == 9)) #tied
	puts "It's a tie!"
else
	if gb.is_player_turn 
		puts "The Computer won as " + COMPUTER + "!"
	else
		puts "Player won as " + PLAYER + "!"
	end
end
