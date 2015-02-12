module TTTRules
	class << self
	
		def is_valid_move?(move, gb)
			gb.valid_moves.include?(move.to_i)
		end

		def opposite_piece(piece)
			return "X" if piece == "O"
			return "O" if piece == "X"
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

		def winner_string(has_winner, num_pieces, human_player, computer_player)
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

		### Winner Evaluations ###
		
		# for computer player's move evaluation. (requires 1 more level of lookahead)
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
		

		### Game Creation Helpers ###

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

		def read_or_new_game
			while(true)
				ConsoleIO.print_message("Welcome to Tic-Tac-Toe! If you would like to start a new game, please type 1. If you would like to load a save file, please type 2.")				
				choice = ConsoleIO.get_input
				if choice == "1"
					return new_game
				elsif choice == "2"
					while(true)
						ConsoleIO.print_message("Please type the file_name of the save file.")
						file_name = ConsoleIO.get_input
						if File.file?(file_name) 
							return read_and_create_game(file_name)
						else
							ConsoleIO.print_message("Invalid file name!")
						end
					end
					break
				else
				;
				end	
			end
		end	

		def new_game
			hp = TTTRules.create_human_player
			cp = TTTRules.create_computer_player(hp.piece)
			gb = TTTRules.create_game_board
			TTTGame.new(gb,hp,cp)
		end

		### Read and Write Game Files ###
		
		def read_and_create_game(file_name)
			game_string = File.read(file_name).split("#")
			gb = read_game_board(game_string[2])
			hp = read_human_player(game_string[3])
			cp = read_computer_player(game_string[4])
			TTTGame.new(gb,hp,cp)
		end

		def read_human_player(hp_string)
			hp = hp_string.split("@")
			piece = hp[1].split("=")[1].gsub(/[^OX]/,"") 
			is_player_turn = 'true' == hp[2].split("=")[1].gsub(/[^a-zA-Z]/,"")
			HumanPlayer.new(piece,is_player_turn)
		end

		def read_computer_player(cp_string)
			cp = cp_string.split("@")
			piece = cp[1].split("=")[1].gsub(/[^OX]/,"") 
			difficulty = determine_difficulty(read_class_name(cp[0]))
			create_computer_helper(difficulty,piece)
		end

		def determine_difficulty(str) 
			case str
			when "EasyAI"
				return "1"
			when "MediumAI"
				return "2"	
			when "HardAI"
				return "3"
			end
		end

		def read_class_name(str)
			str.split(":")[0].gsub(/[^A-Za-z]/,"") 
		end
			
		def read_game_board(gb_string)
			gb = gb_string.split("@")
			board = read_array_object(gb[1].split("=")[1]).map(&:to_s)
			num_pieces = gb[2].split("=")[1].gsub(/[^0-9]/,"").to_i
			valid_moves = read_array_object(gb[3].split("=")[1]).map(&:to_i)
			GameBoard.new(board,num_pieces,valid_moves)
		end

		def read_array_object(array_string)
			array_string.gsub(/[^0-9,a-zA-Z]/,"").split(",")
		end

		def write_game(game, file_name)
			game_string = game.inspect
			File.write(file_name, game_string)		
		end
	end
end
