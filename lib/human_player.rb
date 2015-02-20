require "./lib/player"
require "./lib/ttt_game_writer"

class HumanPlayer < Player

	def initialize(piece)
		super(piece)
	end

  def choose_move(game)
    game.io.print_message("Here's the Game Board. Please type an empty piece location number to place a piece.\nIf you wish to Quit, type Q. If you wish to Save and Quit, type S.")
    piece_location = game.io.get_input
    if piece_location == "Q"
      exit
    elsif piece_location == "S"
      TTTGameWriter.save_game(game.io, game)
    end

    if TTTRules.is_valid_move?(piece_location,game.game_board)
      return piece_location.to_i
    else
      game.io.print_message("Invalid move. Try Again!")
      choose_move(game)
    end
  end

end
