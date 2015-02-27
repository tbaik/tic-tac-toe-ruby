require 'readerwriter/ttt_game_reader'
require 'readerwriter/ttt_game_writer'
require 'ttt_game'
require 'ui/consoleio'
require 'ui/input_checker'
require 'ui/input_processor'

describe TTTGameReader do
  describe '#read_array_object' do
    it 'reads string array object back into normal string array' do
      array = ["1","2","3","4","O","X","7","8","9","10"]
      string = array.inspect
      expect(TTTGameReader.read_array_object(string).map(&:to_s)).to eq(array)
    end

    it 'reads int array object back into normal int array' do
      array = [1,2,3,4,5]
      string = array.inspect
      expect(TTTGameReader.read_array_object(string).map(&:to_i)).to eq(array)
    end
  end

  describe '#read_game_board_variables' do 
    it 'reads game board object string' do
      gb = GameBoard.new(4)
      gb_string = gb.inspect
      new_gb_variables = TTTGameReader.read_game_board_variables(gb_string)
      expect(new_gb_variables[:board]).to eq(gb.board)
      expect(new_gb_variables[:num_pieces]).to eq(gb.num_pieces)
      expect(new_gb_variables[:valid_moves]).to eq(gb.valid_moves)
    end
  end

  describe '#read_human_player_piece' do 
    it 'reads human player object string and gives back piece' do 
      hp = HumanPlayer.new("X")
      hp_string = hp.inspect
      new_hp_piece = TTTGameReader.read_human_player_piece(hp_string)
      expect(new_hp_piece).to eq(hp.piece)
    end
  end

  describe '#read_computer_player_class' do 
    it 'reads computer player object string for EasyAI' do
      cp = EasyAI.new("X")
      cp_string = cp.inspect
      new_cp_class = TTTGameReader.read_computer_player_class(cp_string)
      expect(new_cp_class).to eq(EasyAI)
    end
  end

  describe '#read_is_player_turn' do
    it 'reads game object for is_player_turn and returns boolean true if true' do
      game = TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), TTTUI.new(ConsoleIO, InputProcessor, InputChecker), true)	
      string = game.inspect
      expect(TTTGameReader.read_is_player_turn(string.split("#")[5].split("@")[-2])).to eq(true)
    end
  end

  describe '#read_game' do
    it 'read file given a file_name and create game' do
      game = TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), TTTUI.new(ConsoleIO, InputProcessor, InputChecker), true)	
      file_name = "test2.txt"
      TTTGameWriter.write_game(game,file_name)
      new_game_variables = TTTGameReader.read_game(file_name)
      expect(new_game_variables[:gb_variables][:board]).to eq(game.game_board.board)
      expect(new_game_variables[:gb_variables][:num_pieces]).to eq(game.game_board.num_pieces)
      expect(new_game_variables[:gb_variables][:valid_moves]).to eq(game.game_board.valid_moves)
      expect(new_game_variables[:hp_piece]).to eq(game.human_player.piece)
      expect(new_game_variables[:cp_piece]).to eq(game.computer_player.piece)
      expect(new_game_variables[:cp_class]).to eq(HardAI)
      expect(new_game_variables[:is_player_turn]).to eq(game.is_player_turn)

      File.delete("test2.txt") if File.exist?("test2.txt")
    end
  end

  describe '#read_line_for_words' do
    it 'gives back just the alphabet when looking at a line in a variable' do
      expect(TTTGameReader.read_line_for_words("io=helloIO\n")).to eq("helloIO")
    end 
    
    it 'excludes numbers' do
      expect(TTTGameReader.read_line_for_words("io=12345io\n")).to eq("io")
    end
  end

  describe '#read_class_name' do
    it 'reads the name of the saved class' do 
      cp = HardAI.new("X")
      string = cp.inspect
      expect(TTTGameReader.read_class_name(string)).to eq("HardAI")
    end
  end
end

