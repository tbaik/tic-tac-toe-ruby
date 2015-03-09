require_relative "../player"
require_relative "../../readerwriter/ttt_game_writer"

class HumanPlayer < Player

	def initialize(piece)
		super(piece)
	end

  def choose_move(game)
    piece_location = game.ui.receive_human_turn_choice
    
    if command?(piece_location) 
      process_command(piece_location, game)
    elsif game.rules.is_valid_move?(piece_location,game.game_board)
      return piece_location.to_i
    else
      game.ui.print_invalid_move_error
      choose_move(game)
    end
  end

  def command?(string)
    return string == "Q" || string == "S"
  end

  def process_command(command, game)
    if command == "Q"
      exit
    else
      TTTGameWriter.save_game(game)
    end
  end
end
