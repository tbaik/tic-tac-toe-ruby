require 'ui/consoleio'
require 'board/board_presenter'
require 'board/gameboard'
require 'ui/ttt_ui'
require 'ttt_game'
require 'ui/pig_latin_translator'
require 'ui/input_checker'
require 'ui/input_processor'

describe TTTUI do
  let(:ui) {TTTUI.new(ConsoleIO, InputProcessor, InputChecker)}
  let(:game) {TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), TTTUI.new(ConsoleIO, InputProcessor, InputChecker), true)}	

  it 'is initialized with an io' do
    expect{TTTUI.new(ConsoleIO, InputProcessor, InputChecker)}.not_to raise_error
  end

  describe '#receive_language_choice' do
    it 'receives input 1 or 2 after prompting user' do
      expect(ui.io).to receive(:get_input).and_return("1")
      expect{ui.receive_language_choice}.to output("Type 1 for English and 2 for Pig Latin!\n").to_stdout
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
      expect{ui.print_invalid_move_error}.to output(ui.invalid_move_error + "\n").to_stdout
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
    it 'prints the string from the winner presenter' do
      expect{ui.print_winner(true,game)}.to output("The Computer won as X!\n--------------------------------------------------------------\n").to_stdout
    end

    it 'prints piglatin if translated as piglatin' do
      ui.translate(PigLatinTranslator)
      expect{ui.print_winner(true,game)}.to output("Ethay Omputercay onway asway Xay!\n--------------------------------------------------------------\n").to_stdout
    end
  end

  describe '#print_piece_placed' do
    it 'has expected human player output according to its parameters' do
      is_player_turn = true
      piece = "X"
      piece_location = 1

      expect{ui.print_piece_placed(is_player_turn, piece, piece_location)}.to output("The Player placed X on 1\n").to_stdout
    end

    it 'has expected computer player output according to its parameters' do
      is_player_turn = false
      piece = "O"
      piece_location = 5

      expect{ui.print_piece_placed(is_player_turn, piece, piece_location)}.to output("The Computer placed O on 5\n").to_stdout
    end

    it 'has pig latin output when translated into pig latin' do
      is_player_turn = false
      piece = "O"
      piece_location = 5
      ui.translate(PigLatinTranslator) 
      expect{ui.print_piece_placed(is_player_turn, piece, piece_location)}.to output("Ethay Omputercay acedplay Oway onway 5\n").to_stdout
    end

  end

  describe 'GameCreator UI' do
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

    describe '#receive_board_size' do
      it 'returns same input as given' do
        expect(ui.io).to receive(:print_message)
        expect(ui.io).to receive(:get_input).and_return("4")
        expect(ui.receive_board_size).to eq("4")
      end
    end

    describe '#receive_read_file_name' do
      it 'returns file name if file exists' do
        File.write("test1.txt", "nothing special")
        expect(ui.io).to receive(:print_message)
        expect(ui.io).to receive(:get_input).and_return("test1.txt")
        expect(ui.receive_read_file_name).to eq("test1.txt")
        File.delete("test1.txt") if File.exist?("test1.txt")
      end
    end

    describe '#receive_read_or_new_game' do
      it 'returns 1 on user input 1' do
        expect(ui.io).to receive(:print_message)
        expect(ui.io).to receive(:get_input).and_return("1")
        expect(ui.receive_read_or_new_game).to eq("1")
      end
    end

    describe '#translate' do
      it 'translates instance variable strings in the class through given translator' do
        ui.translate(PigLatinTranslator)
        expect(ui.ask_human_turn).to eq("Erehay'say ethay Amegay Oardbay. Easeplay etypay anway emptyway iecepay ocationlay umbernay otay aceplay away iecepay.\nIfway ouyay ishway otay Uitqay, etypay Qay. Ifway ouyay ishway otay Avesay andway Uitqay, etypay Say.")
        expect(ui.invalid_move_error).to eq("Invalidway ovemay. Tryay Againway!")
      end
      
      it 'sets instance variable translator as the translator given' do
        expect(ui.translator).to eq(nil)
        ui.translate(PigLatinTranslator)
        expect(ui.translator).to eq(PigLatinTranslator)
      end

      it 'sets is_foreign_language boolean to true' do
        expect(ui.is_foreign_language).to eq(false)
        ui.translate(PigLatinTranslator)
        expect(ui.is_foreign_language).to eq(true)
      end
    end
  end
end
