require_relative "../lib/ttt_game_creator"
require_relative "../lib/readerwriter/ttt_game_writer"
require_relative "../lib/readerwriter/ttt_game_reader"
require_relative '../lib/ttt_game'
require_relative '../lib/ui/ttt_ui'
require_relative '../lib/ui/consoleio'
require_relative '../lib/ui/input_checker'
require_relative '../lib/ui/input_processor'

describe TTTGameCreator do
  let(:ui) {TTTUI.new(ConsoleIO, InputProcessor, InputChecker)}
  let(:ttt_creator) {TTTGameCreator.new(ui)}

  it 'initializes with a new TTTUI' do
    expect{TTTGameCreator.new(TTTUI.new(ConsoleIO, InputProcessor, InputChecker))}.not_to raise_error
  end

  describe '#new_game' do
    it 'records user input and creates appropriate game out of it' do
      expect(ui).to receive(:determine_language).and_return("1")
      expect(ui).to receive(:receive_read_or_new_game).and_return("1")
      expect(ui).to receive(:receive_piece_and_turn).and_return(["O",true])
      expect(ui).to receive(:receive_difficulty).and_return(EasyAI)
      expect(ui).to receive(:receive_board_size).and_return(3)

      game = ttt_creator.new_game

      expect(game.game_board.board).to eq(["1","2","3","4","5","6","7","8","9"])
      expect(game.game_board.valid_moves.size).to eq(9)
      expect(game.game_board.num_pieces).to eq(0)
      expect(game.human_player.piece).to eq("O")
      expect(game.computer_player.piece).to eq("X")
      expect(game.computer_player.class).to eq(EasyAI.new("X").class)
      expect(game.is_player_turn).to eq(true)
      expect(game.rules).to eq(TTTRules)
    end
  end

  describe '#create_new_game' do
    it 'takes a variable hash and creates a new game with gb_size' do
      variables_hash = {:gb_size => 3, :hp_piece => "O", :cp_piece => "X", :cp_class => EasyAI, 
        :is_player_turn => true, :rules => TTTRules} 
      game = ttt_creator.create_new_game(variables_hash)
      expect(game.game_board.board).to eq(["1","2","3","4","5","6","7","8","9"])
      expect(game.game_board.valid_moves.size).to eq(9)
      expect(game.game_board.num_pieces).to eq(0)
      expect(game.human_player.piece).to eq("O")
      expect(game.computer_player.piece).to eq("X")
      expect(game.computer_player.class).to eq(EasyAI.new("X").class)
      expect(game.is_player_turn).to eq(true)
      expect(game.rules).to eq(TTTRules)
    end

    it 'takes a variable hash and creates a new game with gb_variables' do
      variables_hash = {:gb_variables => {:board => ["X","2","3","4","5","6","7","8","9"], 
        :num_pieces => 1, :valid_moves => [2,3,4,5,6,7,8,9]},
        :hp_piece => "O", :cp_piece => "X", :cp_class => EasyAI, 
        :is_player_turn => true, :rules => TTTRules} 
      game = ttt_creator.create_new_game(variables_hash)
      expect(game.game_board.board).to eq(["X","2","3","4","5","6","7","8","9"])
      expect(game.game_board.valid_moves.size).to eq(8)
      expect(game.game_board.num_pieces).to eq(1)
      expect(game.human_player.piece).to eq("O")
      expect(game.computer_player.piece).to eq("X")
      expect(game.computer_player.class).to eq(EasyAI.new("X").class)
      expect(game.is_player_turn).to eq(true)
      expect(game.rules).to eq(TTTRules)
    end
  end

  describe '#read_game_variables' do
    it 'loads and reads the saved game and turns it into correct hash of variables' do
      game = TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), EasyAI.new("X"), TTTUI.new(ConsoleIO, InputProcessor, InputChecker), true, TTTRules)
      TTTGameWriter.write_game(game, "test_read.txt")
      expect(ui).to receive(:receive_read_file_name).and_return("test_read.txt")
      variables_hash = ttt_creator.read_game_variables

      expect(variables_hash[:gb_variables][:board]).to eq(game.game_board.board)
      expect(variables_hash[:gb_variables][:num_pieces]).to eq(game.game_board.num_pieces)
      expect(variables_hash[:gb_variables][:valid_moves]).to eq(game.game_board.valid_moves)
      expect(variables_hash[:hp_piece]).to eq(game.human_player.piece)
      expect(variables_hash[:cp_piece]).to eq(game.computer_player.piece)
      expect(variables_hash[:cp_class]).to eq(EasyAI)
      expect(variables_hash[:is_player_turn]).to eq(game.is_player_turn)
      expect(variables_hash[:rules]).to eq(game.rules)

      File.delete("test_read.txt") if File.exist?("test_read.txt")
    end
  end

  describe '#new_game_variables' do
    it 'receives all user input and turns it into correct hash of variables' do
      expect(ui).to receive(:receive_piece_and_turn).and_return(["O",true])
      expect(ui).to receive(:receive_difficulty).and_return(EasyAI)
      expect(ui).to receive(:receive_board_size).and_return(3)

      variables_hash = ttt_creator.new_game_variables

      expect(variables_hash[:gb_size]).to eq(3)
      expect(variables_hash[:hp_piece]).to eq("O")
      expect(variables_hash[:cp_piece]).to eq("X")
      expect(variables_hash[:cp_class]).to eq(EasyAI)
      expect(variables_hash[:is_player_turn]).to eq(true)
      expect(variables_hash[:rules]).to eq(TTTRules)
    end
  end
end
