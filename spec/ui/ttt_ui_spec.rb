require 'ui/consoleio'
require 'board/board_presenter'
require 'board/gameboard'
require 'ui/ttt_ui'
require 'ttt_game'

describe TTTUI do
  let(:ui) {TTTUI.new(ConsoleIO)}
  let(:game) {TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), TTTUI.new(ConsoleIO), true)}	
  it 'is initialized with an io' do
    expect{TTTUI.new(ConsoleIO)}.not_to raise_error
  end

  describe '#receive_human_turn_choice' do
    it 'asks user for input and grabs the input from user' do
      expect(ui.io).to receive(:print_message)
      expect(ui.io).to receive(:get_input)
      ui.receive_human_turn_choice(game)
    end

    it 'exits on Q' do
      expect(ui.io).to receive(:print_message)
      expect(ui.io).to receive(:get_input).and_return("Q")
      expect{ui.receive_human_turn_choice(game)}.to raise_error SystemExit         
    end

    it 'writes a file and exits if you choose to save the game' do
      expect(ui.io).to receive(:print_message).exactly(2).times
      expect(ui.io).to receive(:get_input).and_return("S")
      expect(ui.io).to receive(:get_input).and_return("file2.txt")
      expect{ui.receive_human_turn_choice(game)}.to raise_error SystemExit      
      File.delete("file2.txt") if File.exist? "file2.txt"
    end

  end

  describe '#print_invalid_move_error' do
    it 'prints that the move is invalid' do
      expect(ui.io).to receive(:print_message)
      ui.print_invalid_move_error
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
      expect(WinnerPresenter).to receive(:winner_string).with(true, game)
      ui.print_winner(true, game)
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

  end

  describe 'GameCreator UI' do
    describe '#create_piece_turn_helper' do
      it 'gives us an array of X and true when 1' do
        expect(ui.create_piece_turn_helper("1")).to eq(["X",true])
      end

      it 'gives us an array of O and false when 2' do
        expect(ui.create_piece_turn_helper("2")).to eq(["O",false])
      end

      it 'exits program when 3' do
        expect{ui.create_piece_turn_helper("3")}.to raise_error SystemExit
      end

      it 'gives nil on any other input' do
        expect(ui.create_piece_turn_helper("blah")).to eq(nil)
      end
    end  

    describe '#determine_difficulty' do
      it 'gives back EasyAI when 1' do
        expect(ui.determine_difficulty("1")).to eq(EasyAI)
      end

      it 'gives back MediumAI when 2' do
        expect(ui.determine_difficulty("2")).to eq(MediumAI)
      end

      it 'gives back HardAI when 3' do
        expect(ui.determine_difficulty("3")).to eq(HardAI)
      end

      it 'gives nil on any other input' do
        expect(ui.determine_difficulty("blah")).to eq(nil)
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

  end
end
