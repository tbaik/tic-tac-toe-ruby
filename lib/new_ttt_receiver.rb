class NewTTTReceiver
  attr_reader :io

  def initialize(io)
    @io = io
  end

  def receive_board_size
    @io.print_message("Please select a Game Board size: 3x3(3), 4x4(4), or 5x5(5)")
    gb_size = @io.get_input
    if !gb_size.nil? && (gb_size.to_i > 2 && gb_size.to_i < 6)
      return gb_size
    else
      receive_board_size
    end
  end

  def receive_piece_and_turn
      @io.print_message("Hello! Let's play a game of tic-tac-toe against a computer!\nPlease type 1 to go First(X), 2 to go Second(O), or 3 to exit")
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
    @io.print_message("Choose the difficulty of the Computer: Easy(1), Medium(2), or Hard(3)")
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
    @io.print_message("Welcome to Tic-Tac-Toe! If you would like to start a new game, please type 1. If you would like to load a save file, please type 2.")				
    choice = @io.get_input
    if choice == "1" || choice == "2"
      return choice
    else
      receive_read_or_new_game
    end	
  end	

  def receive_read_file_name
    @io.print_message("Please type the file_name of the save file.")
    file_name = @io.get_input
    if File.file?(file_name) 
      return file_name 
    else
      @io.print_message("Invalid file name!")
      receive_read_file_name
    end
  end

end
