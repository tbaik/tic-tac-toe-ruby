module TTTGameCreator
	class << self

		def create_game_board(io)
			while(true)
				io.print_message("Please select a Game Board size: 3x3(3), 4x4(4), or 5x5(5)")
				gb_size = io.get_input
				if !gb_size.nil? && (gb_size.to_i > 2 && gb_size.to_i < 6)
					return GameBoard.new(gb_size)	
				end
			end
		end

		def create_human_player(io)
			while(true)	
				io.print_message("Hello! Let's play a game of tic-tac-toe against a computer!\nPlease type 1 to go First(X), 2 to go Second(O), or 3 to exit")
				turn = io.get_input
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

		def create_computer_player(human_piece,io)	
			while(true)
				io.print_message("Choose the difficulty of the Computer: Easy(1), Medium(2), or Hard(3)")
				difficulty = io.get_input
				computer = create_computer_helper(difficulty, TTTRules.opposite_piece(human_piece)) 
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
			io = ConsoleIO
			hp = create_human_player(io)
			cp = create_computer_player(hp.piece,io)
			gb = create_game_board(io)
			TTTGame.new(gb,hp,cp,io)
		end

		def read_and_create_game(file_name)
			game_string = File.read(file_name).split("#")
			gb = read_and_create_game_board(game_string[2])
			hp = read_and_create_human_player(game_string[3])
			cp = read_and_create_computer_player(game_string[4])
			TTTGame.new(gb,hp,cp,ConsoleIO)
		end

		def write_game(game, file_name)
			game_string = game.inspect
			File.write(file_name, game_string)		
		end

		def read_and_create_human_player(hp_string)
			hp = hp_string.split("@")
			piece = hp[1].split("=")[1].gsub(/[^OX]/,"") 
			is_player_turn = 'true' == hp[2].split("=")[1].gsub(/[^a-zA-Z]/,"")
			HumanPlayer.new(piece,is_player_turn)
		end

		def read_and_create_computer_player(cp_string)
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
			
		def read_and_create_game_board(gb_string)
			gb = gb_string.split("@")
			board = read_array_object(gb[1].split("=")[1]).map(&:to_s)
			num_pieces = gb[2].split("=")[1].gsub(/[^0-9]/,"").to_i
			valid_moves = read_array_object(gb[3].split("=")[1]).map(&:to_i)
			GameBoard.new(board,num_pieces,valid_moves)
		end

		def read_array_object(array_string)
			array_string.gsub(/[^0-9,a-zA-Z]/,"").split(",")
		end

	end
end
