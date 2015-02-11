module TTTRules
	class << self
	
		def is_valid_move?(move, gb)
			gb.valid_moves.include?(move.to_i)
		end

		#for the purposes of computer player evaluation.
		def has_winner_eval(game_board)
			return false if game_board.num_pieces < ((Math.sqrt(game_board.board.size) * 2) - 1)-1 
			has_vertical_winner(game_board.board) || has_horizontal_winner(game_board.board) || has_diagonal_winner(game_board.board)
		end

		def has_winner(game_board)
			return false if game_board.num_pieces < ((Math.sqrt(game_board.board.size) * 2) - 1) 
			has_vertical_winner(game_board.board) || has_horizontal_winner(game_board.board) || has_diagonal_winner(game_board.board)
		end

		def has_vertical_winner(board)
			length = Math.sqrt(board.size).to_i	
			
			length.times do |i|
				num = i
				bool = true
				while num < board.size-length
					if board[num] != board[num+length]	
						bool = false
					end
					num += length
				end
				if bool
					return true
				end
			end
			false
		end
	
		def has_horizontal_winner(board)
			num = 0
			length = Math.sqrt(board.size).to_i
			while num < board.size
				bool = true 
				(length - 1).times do |i|
					if board[num] != board[num+i+1]
						bool = false	
					end
				end
				if bool
					return true
				else
					num += length
				end
			end
			false
		end

		def has_diagonal_winner(board)
			length = Math.sqrt(board.size).to_i
			num = 0
			bool = true
			while num < board.size - length
				if board[num] != board[num+1+length]
					bool = false
				end
				num += length + 1
			end	
			if bool
				return true
			end

			num = length-1
			bool = true
			while num < board.size - length
				if board[num] != board[num-1+length]
					bool = false
				end
				num += length - 1
			end
			if bool
				return true
			end
			false
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
					if count < 9 || board[count] == "O" || board[count] == "X"
						board_string << "  " + board[count] + "  |"
					else
						board_string << "  " + board[count] + " |"
					end
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
			if (!has_winner) #tied
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

		def create_game_board
			while(true)
				ConsoleIO.print_message("Please select a Game Board size: 3x3(3), 4x4(4), or 5x5(5)")
				gb_size = ConsoleIO.get_input
				if !gb_size.nil? && (gb_size.to_i > 2 && gb_size.to_i < 6)
					return GameBoard.new(gb_size)	
				end
			end
		end

		def create_human_player
			while(true)	
				ConsoleIO.print_message("Hello! Let's play a game of tic-tac-toe against a computer!\nPlease type 1 to go First(X), 2 to go Second(O), or 3 to exit")
				turn = ConsoleIO.get_input
				human = create_human_helper(turn)
				return human if !human.nil?	
			end
		end

		def create_human_helper(turn)
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
				computer = create_computer_helper(difficulty, opposite_piece(human_piece)) 
				return computer if !computer.nil?
			end	
		end

		def create_computer_helper(difficulty, piece)
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
