require "./lib/board/board_presenter"
require "./lib/readerwriter/ttt_game_writer"
require "./lib/ui/output_determiner"

class TTTUI
  attr_reader :io, :input_processor, :input_checker, :text 
  ASK_LANGUAGE = "Type 1 for English and 2 for Pig Latin, and 3 for Spanish!"
  END_OF_GAME = "\n--------------------------------------------------------------"

  def initialize(io, input_processor, input_checker)
    @io = io
    @input_processor = input_processor
    @input_checker = input_checker
    @text = @input_processor.process_language_input("1")
  end

  def determine_language
    @io.print_message(ASK_LANGUAGE)
    choice = @io.get_input
    if @input_checker.valid_language_input?(choice)
       text_hash = @input_processor.process_language_input(choice)
       @text = text_hash
    else
      determine_language
    end
  end

  def receive_human_turn_choice
    @io.print_message(@text[:ask_human_turn])
    @io.get_input
  end

  def print_invalid_move_error
    @io.print_message(@text[:invalid_move_error])
  end

  def receive_save_file_name
    @io.print_message(@text[:ask_file_name])
    file_name = @io.get_input
    if file_name != ""	
      return file_name
    else
      @io.print_message(@text[:invalid_file_name])
      receive_save_file_name
    end
  end

  def print_gameboard(board)
    @io.print_message(BoardPresenter.board_string(board))
  end

  def print_winner(has_winner, game)
    winner_symbol = OutputDeterminer.determine_winner_symbol(has_winner, game)
    winner_piece = game.is_player_turn ? game.computer_player.piece : game.human_player.piece
    winner_piece = "" if !has_winner
    @io.print_message(@text[winner_symbol] + winner_piece + "!" + END_OF_GAME) 
  end

  def print_piece_placed(is_player_turn, piece, piece_location)
    piece_placed_symbol = OutputDeterminer.determine_piece_placed_symbol(is_player_turn)
    @io.print_message(@text[piece_placed_symbol] + piece + " @ " + piece_location.to_s)
  end

  def receive_board_size
    @io.print_message(@text[:ask_board_size])
    gb_size = @io.get_input
    if @input_checker.valid_board_size?(gb_size) 
      return gb_size
    else
      receive_board_size
    end
  end

  def receive_piece_and_turn
    @io.print_message(@text[:ask_turn])
    piece_and_turn = @input_processor.process_piece_and_turn_input(@io.get_input)
    if !piece_and_turn.nil?	
      return piece_and_turn
    else
      receive_piece_and_turn
    end
  end

  def receive_difficulty
    @io.print_message(@text[:ask_difficulty])
    difficulty = @input_processor.process_difficulty_input(@io.get_input)
    if !difficulty.nil? 
      return difficulty
    else
      receive_difficulty
    end
  end

  def receive_read_or_new_game
    @io.print_message(@text[:ask_read_or_new_game])
    choice = @io.get_input
    if @input_checker.valid_read_or_new_game_input?(choice) 
      return choice
    else
      receive_read_or_new_game
    end	
  end	

  def receive_read_file_name
    @io.print_message(@text[:ask_file_name])
    file_name = @io.get_input
    if @input_checker.valid_file_name?(file_name) 
      return file_name 
    else
      @io.print_message(@text[:invalid_file_name])
      receive_read_file_name
    end
  end
end
