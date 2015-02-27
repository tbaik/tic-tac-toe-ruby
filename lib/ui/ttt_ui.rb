require "./lib/board/board_presenter"
require "./lib/readerwriter/ttt_game_writer"

class TTTUI
  attr_reader :io, :input_processor, :input_checker, :ask_human_turn, :invalid_move_error, :is_foreign_language, :translator
  ASK_LANGUAGE = "Type 1 for English and 2 for Pig Latin!"

  def initialize(io, input_processor, input_checker)
    @io = io
    @input_processor = input_processor
    @input_checker = input_checker
    @ask_human_turn = "Here's the Game Board. Please type an empty piece location number to place a piece.\n" +
      "If you wish to Quit, type Q. If you wish to Save and Quit, type S."
    @invalid_move_error = "Invalid move. Try Again!"
    @ask_file_name = "Please type the name of the save file:"
    @invalid_file_name = "Invalid file name!"
    @ask_board_size = "Please select a Game Board size: 3x3(3), 4x4(4), or 5x5(5)"
    @ask_turn = "Hello! Let's play a game of tic-tac-toe against a computer!\nPlease type 1 to go First(X), 2 to go Second(O), or 3 to exit"
    @ask_difficulty = "Choose the difficulty of the Computer: Easy(1), Medium(2), or Hard(3)"
    @ask_read_or_new_game = "Welcome to Tic-Tac-Toe! If you would like to start a new game, please type 1. If you would like to load a save file, please type 2."
    @is_foreign_language = false
    @translator = nil
  end

  def receive_language_choice
    @io.print_message(ASK_LANGUAGE)
    choice = @io.get_input
    if @input_checker.valid_language_input?(choice)
      return choice
    else
      receive_language_choice
    end
  end

  def receive_human_turn_choice
    @io.print_message(@ask_human_turn)
    @io.get_input
  end

  def print_invalid_move_error
    @io.print_message(@invalid_move_error)
  end

  def receive_save_file_name
    @io.print_message(@ask_file_name)
    file_name = @io.get_input
    if file_name != ""	
      return file_name
    else
      @io.print_message(@invalid_file_name)
      receive_save_file_name
    end
  end

  def print_gameboard(board)
    @io.print_message(BoardPresenter.board_string(board))
  end

  def print_winner(has_winner, game)
    output_string = ""
    if @is_foreign_language
      output_string = @translator.translate_string(WinnerPresenter.winner_string(has_winner, game))
    else
      output_string = WinnerPresenter.winner_string(has_winner, game)
    end
    @io.print_message(output_string) 
  end

  def print_piece_placed(is_player_turn, piece, piece_location)
    output_string = ""
    if is_player_turn
      output_string = "The Player placed " + piece + " on " + piece_location.to_s
    else
      output_string = "The Computer placed " + piece + " on " + piece_location.to_s
    end

    if @is_foreign_language
      output_string = @translator.translate_string(output_string)
    end

    @io.print_message(output_string)
  end

  def receive_board_size
    @io.print_message(@ask_board_size)
    gb_size = @io.get_input
    if @input_checker.valid_board_size?(gb_size) 
      return gb_size
    else
      receive_board_size
    end
  end

  def receive_piece_and_turn
    @io.print_message(@ask_turn)
    piece_and_turn = @input_processor.process_piece_and_turn_input(@io.get_input)
    if !piece_and_turn.nil?	
      return piece_and_turn
    else
      receive_piece_and_turn
    end
  end

  def receive_difficulty
    @io.print_message(@ask_difficulty)
    difficulty = @input_processor.process_difficulty_input(@io.get_input)
    if !difficulty.nil? 
      return difficulty
    else
      receive_difficulty
    end
  end

  def receive_read_or_new_game
    @io.print_message(@ask_read_or_new_game)				
    choice = @io.get_input
    if @input_checker.valid_read_or_new_game_input?(choice) 
      return choice
    else
      receive_read_or_new_game
    end	
  end	

  def receive_read_file_name
    @io.print_message(@ask_file_name)
    file_name = @io.get_input
    if @input_checker.valid_file_name?(file_name) 
      return file_name 
    else
      @io.print_message(@invalid_file_name)
      receive_read_file_name
    end
  end

  def translate(translator)
    @translator = translator
    @is_foreign_language = true
    self.instance_variables[3..-3].each do |string_var|
      self.instance_variable_set(string_var, @translator.translate_string(self.instance_variable_get(string_var)))  
    end 
  end
end
