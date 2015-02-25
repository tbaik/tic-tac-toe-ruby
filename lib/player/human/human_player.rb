require "./lib/player/player"
require "./lib/readerwriter/ttt_game_writer"

class HumanPlayer < Player

	def initialize(piece)
		super(piece)
	end

  def choose_move(game)
    piece_location = game.ui.receive_human_turn_choice(game)
   
    if TTTRules.is_valid_move?(piece_location,game.game_board)
      return piece_location.to_i
    else
      game.ui.print_invalid_move_error
      choose_move(game)
    end
  end

end
