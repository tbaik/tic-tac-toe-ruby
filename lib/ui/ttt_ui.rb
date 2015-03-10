require "board/board_presenter"
require "ui/output_determiner"

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
    language_input = receive_input_with_checker(ASK_LANGUAGE, :valid_language_input?)
    @text = @input_processor.process_language_input(language_input)
  end

  def receive_human_turn_choice
    @io.print_message(@text[:ask_human_turn])
    @io.get_input
  end

  def print_invalid_move_error
    @io.print_message(@text[:invalid_move_error])
  end

  def receive_save_file_name
    receive_input_with_checker_and_invalid_response(@text[:ask_file_name], :valid_file_name?, @text[:invalid_file_name])
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
    receive_input_with_checker(@text[:ask_board_size], :valid_board_size?)
  end

  def receive_piece_and_turn
    receive_process_and_check_input(@text[:ask_turn], :process_piece_and_turn_input)
  end

  def receive_difficulty
    receive_process_and_check_input(@text[:ask_difficulty], :process_difficulty_input)
  end

  def receive_read_or_new_game
    receive_input_with_checker(@text[:ask_read_or_new_game], :valid_read_or_new_game_input?)
  end

  def receive_read_file_name
    receive_input_with_checker_and_invalid_response(@text[:ask_file_name], :existing_file_name?, @text[:invalid_file_name])
  end

  def receive_input_with_checker(prompt_text, checker_method)
    @io.print_message(prompt_text)
    input = @io.get_input
    if @input_checker.send(checker_method, input)
      return input
    else
      receive_input_with_checker(prompt_text, checker_method)
    end
  end

  def receive_process_and_check_input(prompt_text, processor_method)
    @io.print_message(prompt_text)
    processed_input = @input_processor.send(processor_method, @io.get_input)
    if !processed_input.nil?
      return processed_input
    else
      receive_process_and_check_input(prompt_text, processor_method)
    end
  end

  def receive_input_with_checker_and_invalid_response(prompt_text, checker_method, invalid_text)
    @io.print_message(prompt_text)
    input = @io.get_input
    if @input_checker.send(checker_method, input)
      return input
    else
      @io.print_message(invalid_text)
      receive_input_with_checker_and_invalid_response(prompt_text, checker_method, invalid_text)
    end
  end

end
