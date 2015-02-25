require "./lib/board/board_presenter"
require "./lib/readerwriter/ttt_game_writer"

class TTTUI
  attr_accessor :io

  def initialize(io)
    @io = io
    @ask_human_turn = "Here's the Game Board. Please type an empty piece location number to place a piece.\n" +
      "If you wish to Quit, type Q. If you wish to Save and Quit, type S."
    @invalid_move_error = "Invalid move. Try Again!"
    @ask_file_name = "Please type the name of the save file:"
    @invalid_file_name = "Invalid file name!"
    @ask_board_size = "Please select a Game Board size: 3x3(3), 4x4(4), or 5x5(5)"
    @ask_turn = "Hello! Let's play a game of tic-tac-toe against a computer!\nPlease type 1 to go First(X), 2 to go Second(O), or 3 to exit"
    @ask_difficulty = "Choose the difficulty of the Computer: Easy(1), Medium(2), or Hard(3)"
    @ask_read_or_new_game = "Welcome to Tic-Tac-Toe! If you would like to start a new game, please type 1. If you would like to load a save file, please type 2."
  end

  def receive_human_turn_choice(game)
    @io.print_message(@ask_human_turn)
    piece_location = @io.get_input

    if piece_location == "Q"
      exit
    elsif piece_location == "S"
      TTTGameWriter.save_game(game)
    else
      return piece_location
    end
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
    @io.print_message(WinnerPresenter.winner_string(has_winner, game)) 
  end

  def print_piece_placed(is_player_turn, piece, piece_location)
    if is_player_turn
      @io.print_message("The Player placed " + piece + " on " + piece_location.to_s)
    else
      @io.print_message("The Computer placed " + piece + " on " + piece_location.to_s)
    end
  end

  def receive_board_size
    @io.print_message(@ask_board_size)
    gb_size = @io.get_input
    if !gb_size.nil? && (gb_size.to_i > 2 && gb_size.to_i < 6)
      return gb_size
    else
      receive_board_size
    end
  end

  def receive_piece_and_turn
    @io.print_message(@ask_turn)
    piece_and_turn = create_piece_turn_helper(@io.get_input)
    if !piece_and_turn.nil?	
      return piece_and_turn
    else
      receive_piece_and_turn
    end
  end

  def create_piece_turn_helper(turn)
    case turn
    when "1"
      return ["X", true]
    when "2"
      return ["O", false]
    when "3"
      exit
    else
      nil
    end
  end

  def receive_difficulty
    @io.print_message(@ask_difficulty)
    difficulty = determine_difficulty(@io.get_input)
    if !difficulty.nil? 
      return difficulty
    else
      receive_difficulty
    end
  end

  def determine_difficulty(difficulty)
    case difficulty
    when "1"
      EasyAI
    when "2"
      MediumAI
    when "3"
      HardAI
    else
      nil
    end	
  end

  def receive_read_or_new_game
    @io.print_message(@ask_read_or_new_game)				
    choice = @io.get_input
    if choice == "1" || choice == "2"
      return choice
    else
      receive_read_or_new_game
    end	
  end	

  def receive_read_file_name
    @io.print_message(@ask_file_name)
    file_name = @io.get_input
    if File.file?(file_name) 
      return file_name 
    else
      @io.print_message(@invalid_file_name)
      receive_read_file_name
    end
  end
end
