module TTTRules
	class << self

		def is_valid_move?(move, gb)
			gb.valid_moves.include?(move.to_i)
		end

		def has_winner(game_board)
			return false if game_board.num_pieces < 5
			has_vertical_winner(game_board.board) || has_horizontal_winner(game_board.board) || has_diagonal_winner(game_board.board)
		end

		def has_vertical_winner(board)
			3.times do |i|
				if ((board[i] == board[i+3]) && (board[i] == board[i+6]))
					return true
				end
			end
			false
		end

		def has_horizontal_winner(board)
			num = 0;
			while num < 9
				if ((board[num] == board[num+1]) && (board[num] == board[num+2]))
					return true
				else
					num += 3;
				end
			end
			false
		end

		def has_diagonal_winner(board)
			(((board[0] == board[4]) && (board[0] == board[8])) || ((board[2] == board[4]) && (board[2] == board[6])))
		end

		# Print current board
		def board_string(board)
			board_string = ""
			width = Math.sqrt(board.length).to_i
			count = 0 
			width.times do |i|
				width.times do 
					board_string << "     |"
				end
				board_string << "\n"
				width.times do |j|
					board_string << "  " + board[count] + "  |"
					count = count + 1
				end
				board_string << "\n"
				width.times do 
					board_string << "     |" 	
				end
				board_string << "\n"
				width.times do
					board_string << "------"
				end
				board_string << "\n"
			end
			board_string		
		end

		def winner_output(has_winner, num_pieces, human_player, computer_player)
			output_string = ""	
			# We have a winner or a tie!
			if (!has_winner && (num_pieces == 9)) #tied
				output_string << "It's a tie!"
			else
				if human_player.is_player_turn 
					output_string << "The Computer won as " + computer_player.piece + "!"
				else
					output_string << "Player won as " + human_player.piece + "!"
				end
			end
			output_string << "\n--------------------------------------------------------------"
		end

		def create_human_player
			while(true)	
				ConsoleIO.print_message("Hello! Let's play a game of tic-tac-toe against a computer!\nPlease type 1 to go First(X), 2 to go Second(O), or 3 to exit")
				turn = ConsoleIO.get_input
				human = create_human(turn)
				return human if !human.nil?	
			end
		end

		def create_human(turn)
			case turn
			when "1"
				HumanPlayer.new("X", true)
			when "2"
				HumanPlayer.new("O", false)
			when "3"
				exit
			else
				nil
			end
		end

		def create_computer_player(human_piece)	
			while(true)
				ConsoleIO.print_message("Choose the difficulty of the Computer: Easy(1), Medium(2), or Hard(3)")
				difficulty = ConsoleIO.get_input
				computer = create_computer(difficulty, opposite_piece(human_piece)) 
				return computer if !computer.nil?
			end	
		end

		def create_computer(difficulty, piece)
			case difficulty
			when "1"
				EasyAI.new(piece)
			when "2"
				MediumAI.new(piece)
			when "3"
				HardAI.new(piece)
			else
				nil
			end	
		end

		def opposite_piece(piece)
			return "X" if piece == "O"
			return "O" if piece == "X"
		end
	end
end
