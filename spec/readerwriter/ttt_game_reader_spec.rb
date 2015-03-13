require 'readerwriter/ttt_game_reader'
require 'readerwriter/ttt_game_writer'
require 'ttt_rules'
require 'ttt_game'
require 'board/gameboard'
require 'player/human/human_player'
require 'ui/consoleio'
require 'ui/input_checker'
require 'ui/input_processor'
require 'ui/ttt_ui'

describe TTTGameReader do
  describe '#read_game' do
    it 'read file given a file_name and create game' do
      game = TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), TTTUI.new(ConsoleIO, InputProcessor, InputChecker), true, TTTRules)	
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
      expect(new_game_variables[:rules]).to eq(game.rules)

      File.delete("test2.txt") if File.exist?("test2.txt")
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
end
