class HumanPlayer
	attr_accessor :is_player_turn
	attr_reader :piece

	def initialize(piece, is_player_turn)
		@piece = piece
		@is_player_turn = is_player_turn
	end
	
	def choose_move(game)
		while(true)
			ConsoleIO.print_message("Here's the Game Board. Please type an empty piece location (1-9) to place a piece.")
			piece_location = ConsoleIO.get_input
			if TTTRules.is_valid_move?(piece_location,game.game_board)
				game.make_move(piece_location.to_i, game.human_player.piece) # make a move
				ConsoleIO.print_message("Player places " + game.human_player.piece + " on " + piece_location)
				break;
			else
				ConsoleIO.print_message("Invalid move. Try Again!")
			end
		end
	end
	
	def changeTurn
		@is_player_turn = !@is_player_turn
	end
end
