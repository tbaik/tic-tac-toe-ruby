require_relative '../../lib/player/ai/easy_ai'
require_relative '../../lib/ttt_game'
require_relative '../../lib/ui/consoleio'
require_relative '../../lib/ui/input_checker'
require_relative '../../lib/ui/input_processor'

describe EasyAI do
  let(:game) {TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), EasyAI.new("X"), TTTUI.new(ConsoleIO, InputProcessor, InputChecker), false, TTTRules)}

  it 'is initialized with piece string' do 
    expect(-> {EasyAI.new("X")}).not_to raise_error
  end 

  describe '#choose_move' do
    it 'gives us a random but valid piece location if no possible tic-tac-toe.' do
      expect(game.game_board.valid_moves.length).to eq(9)
      piece_location = game.computer_player.choose_move(game)
      expect(game.game_board.valid_moves.include?(piece_location)).to eq(true)
    end
  
    it 'chooses piece location for a possible tic-tac-toe on the next move' do
      game.game_board.place_piece(1,"X")
      game.game_board.place_piece(4,"O")
      game.game_board.place_piece(2,"X")
      game.game_board.place_piece(8,"O")

      piece_location = game.computer_player.choose_move(game)
      expect(piece_location).to eq(3)
    end
  end
end


