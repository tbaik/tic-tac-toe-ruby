require 'ui/ttt_ui'
require 'ui/consoleio'
require 'board/gameboard'
require 'player/human/human_player'
require 'ttt_game'
require 'ttt_rules'
require 'ui/input_checker'
require 'ui/input_processor'

describe TTTUI do
  let(:ui) {TTTUI.new(ConsoleIO, InputProcessor, InputChecker)}

  it 'is initialized with an io' do
    expect{TTTUI.new(ConsoleIO, InputProcessor, InputChecker)}.not_to raise_error
  end

  describe '#receive_and_set_language_choice' do
    it 'receives 1 for english and sets text as english' do
      expect(ui.io).to receive(:get_input).and_return("1")
      expect{ui.receive_and_set_language_choice}.to output("Type 1 for English and 2 for Pig Latin, and 3 for Spanish!\n").to_stdout
      expect(ui.text[:invalid_file_name]).to eq("Invalid file name!")
    end
  end

  describe '#receive_human_turn_choice' do
    it 'asks user for input and grabs the input from user' do
      expect(ui.io).to receive(:print_message)
      expect(ui.io).to receive(:get_input)
      ui.receive_human_turn_choice
    end
  end

  describe '#print_invalid_move_error' do
    it 'prints that the move is invalid' do
      expect{ui.print_invalid_move_error}.to output(ui.text[:invalid_move_error] + "\n").to_stdout
    end
  end

  describe '#receive_save_file_name' do
    it 'prints message and gets input from with io' do
      expect(ui.io).to receive(:print_message)
      expect(ui.io).to receive(:get_input).and_return("file")
      file_name = ui.receive_save_file_name
      expect(file_name).to eq("file")
    end

    it 'does not allow blank file names' do
      expect(ui.io).to receive(:print_message).exactly(3).times
      expect(ui.io).to receive(:get_input).and_return("", "file")
      ui.receive_save_file_name
    end
  end

  describe '#print_gameboard' do
    it 'prints the string from board presenter' do
      board = GameBoard.new(3).board
      expect(BoardPresenter).to receive(:board_string).with(board)
      expect(ui.io).to receive(:print_message)
      ui.print_gameboard(board)
    end
  end

  describe '#print_winner' do
  let(:game) {TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), TTTUI.new(ConsoleIO, InputProcessor, InputChecker), true, TTTRules)}	
    it 'prints the string from the winner presenter' do
      expect{ui.print_winner(true,game)}.to output("The Computer won as X!\n--------------------------------------------------------------\n").to_stdout
    end
  end

  describe '#print_piece_placed' do
    it 'has expected human player output according to its parameters' do
      is_player_turn = true
      piece = "X"
      piece_location = 1

      expect{ui.print_piece_placed(is_player_turn, piece, piece_location)}.to output("The Player placed X @ 1\n").to_stdout
    end

    it 'has expected computer player output according to its parameters' do
      is_player_turn = false
      piece = "O"
      piece_location = 5

      expect{ui.print_piece_placed(is_player_turn, piece, piece_location)}.to output("The Computer placed O @ 5\n").to_stdout
    end
  end

  describe 'GameCreator UI' do
    describe '#receive_board_size' do
      it 'returns same input as given' do
        expect(ui.io).to receive(:print_message)
        expect(ui.io).to receive(:get_input).and_return("4")
        expect(ui.receive_board_size).to eq("4")
      end
    end

    describe '#receive_piece_and_turn' do
      it 'returns X and true on user input 1' do
        expect(ui.io).to receive(:print_message)
        expect(ui.io).to receive(:get_input).and_return("1")
        expect(ui.receive_piece_and_turn).to eq(["X",true])
      end

      it 'returns O and false on user input 2' do
        expect(ui.io).to receive(:print_message)
        expect(ui.io).to receive(:get_input).and_return("2")
        expect(ui.receive_piece_and_turn).to eq(["O",false])
      end

      it 'exits on user input 3' do
        expect(ui.io).to receive(:print_message)
        expect(ui.io).to receive(:get_input).and_return("3")
        expect{ui.receive_piece_and_turn}.to raise_error SystemExit
      end
    end

    describe '#receive_difficulty' do
      it 'returns EasyAI on user input 1' do
        expect(ui.io).to receive(:print_message)
        expect(ui.io).to receive(:get_input).and_return("1")
        expect(ui.receive_difficulty).to eq(EasyAI)
      end

      it 'returns MediumAI on user input 2' do
        expect(ui.io).to receive(:print_message)
        expect(ui.io).to receive(:get_input).and_return("2")
        expect(ui.receive_difficulty).to eq(MediumAI)
      end

      it 'returns HardAI on user input 3' do
        expect(ui.io).to receive(:print_message)
        expect(ui.io).to receive(:get_input).and_return("3")
        expect(ui.receive_difficulty).to eq(HardAI)
      end
    end

    describe '#receive_read_or_new_game' do
      it 'returns 1 on user input 1' do
        expect(ui.io).to receive(:print_message)
        expect(ui.io).to receive(:get_input).and_return("1")
        expect(ui.receive_read_or_new_game).to eq("1")
      end

      it 'returns invalid input message until correct input' do
        expect(ui.io).to receive(:print_message).exactly(3).times
        expect(ui.io).to receive(:get_input).and_return("abcd", "1")
        expect(ui.receive_read_or_new_game).to eq("1")
      end
    end

    describe '#receive_read_file_name' do
      it 'returns file name if file exists' do
        file_name = "test1.txt"
        File.write(file_name, "nothing special")
        expect(ui.io).to receive(:print_message)
        expect(ui.io).to receive(:get_input).and_return(file_name)
        expect(ui.receive_read_file_name).to eq(file_name)
        File.delete(file_name) if File.exist?(file_name)
      end

      it 'returns invalid input message and makes you try again if invalid' do
        file_name = "test1.txt"
        File.write(file_name, "nothing special")
        expect(ui.io).to receive(:print_message).exactly(3).times
        expect(ui.io).to receive(:get_input).and_return("nonexistant_file.txt", file_name)
        expect(ui.receive_read_file_name).to eq(file_name)
        File.delete(file_name) if File.exist?(file_name)
      end
    end
  end

  describe '#receive_process_and_check_input' do
    it 'prints given text, process input, check if it is nil and returns valid input' do
      expect(ui.io).to receive(:print_message)
      expect(ui.io).to receive(:get_input).and_return("1")
      expect(ui.receive_process_and_check_input("ask_turn", :process_piece_and_turn_input)).to eq(["X",true])
    end

    it 'repeats if given invalid input' do
      expect(ui.io).to receive(:print_message).exactly(2).times
      expect(ui.io).to receive(:get_input).and_return("5", "1")
      expect(ui.receive_process_and_check_input("ask_turn", :process_piece_and_turn_input)).to eq(["X",true])
    end
  end

  describe '#receive_input_with_checker' do
    it 'prints string, gets input, check input, return on valid input' do
      expect(ui.io).to receive(:print_message)
      expect(ui.io).to receive(:get_input).and_return("file.txt")
      expect(ui.receive_input_with_checker("ask file name", :valid_file_name?, "invalid input!")).to eq("file.txt")
    end

    it 'repeats prompt text and also outputs invalid text response on invalid input' do
      expect(ui.io).to receive(:print_message).exactly(3).times
      expect(ui.io).to receive(:get_input).and_return("", "file.txt")
      expect(ui.receive_input_with_checker("ask file name", :valid_file_name?, "invalid input!")).to eq("file.txt")
    end
  end
end
