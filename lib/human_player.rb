require "./lib/player"

class HumanPlayer < Player
	attr_accessor :is_player_turn

	def initialize(piece, is_player_turn)
		super(piece)
		@is_player_turn = is_player_turn
	end

	def choose_move(game)
		while(true)
			game.io.print_message("Here's the Game Board. Please type an empty piece location number to place a piece.\nIf you wish to Quit, type Q. If you wish to Save and Quit, type S.")
			piece_location = game.io.get_input
			if piece_location == "Q"
				exit
			elsif piece_location == "S"
				while(true)
					game.io.print_message("Please type the name of the save file:")
					file_name = game.io.get_input
					if file_name != ""	
						TTTGameCreator.write_game(game, file_name)
						exit
					end
				end
			end
			if TTTRules.is_valid_move?(piece_location,game.game_board)
				game.make_move(piece_location.to_i, game.human_player.piece) # make a move
				game.io.print_message("Player places " + game.human_player.piece + " on " + piece_location)
				break;
			else
				game.io.print_message("Invalid move. Try Again!")
			end
		end
	end

	def changeTurn
		@is_player_turn = !@is_player_turn
	end
end
