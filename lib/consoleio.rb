module ConsoleIO

	def self.start_game_input
		puts "Hello! Let's play a game of tic-tac-toe against a computer!"
		puts "Please type 1 to go First(X), 2 to go Second(O), or 3 to exit"
		gets.chomp
	end

	def self.next_piece_input
		puts "Here's the Game Board. Please type an empty piece location (1-9) to place a piece."
		gets.chomp
	end

	def self.place_player_piece(player_piece, piece_location)
		puts "Player places " + player_piece + " on " + piece_location
	end

	def self.place_computer_piece(computer_piece, piece_location)
		puts "Computer places " + computer_piece + " on " + piece_location
	end

	def self.invalid_move
		puts "Invalid move. Try Again!"
	end

	def self.winner_output(has_winner, num_pieces, player)
		# We have a winner or a tie!
		if (!has_winner && (num_pieces == 9)) #tied
			puts "It's a tie!"
		else
			if player.is_player_turn 
				puts "The Computer won as " + player.opponent_piece + "!"
			else
				puts "Player won as " + player.piece + "!"
			end
		end
		puts "--------------------------------------------------------------"
	end
end