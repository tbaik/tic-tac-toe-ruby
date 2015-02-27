require 'ttt_game'
require 'ui/consoleio'
require 'ui/input_checker'
require 'ui/input_processor'

describe MediumAI do
  let(:game) {TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), MediumAI.new("X"), TTTUI.new(ConsoleIO, InputProcessor, InputChecker), false, TTTRules)}

  it 'is initialized with piece string' do 
    expect(-> {MediumAI.new("X")}).not_to raise_error
  end 

  describe '#choose_move' do
    it 'chooses piece location for a possible tic-tac-toe on the next move' do
      game.make_move(1)
      game.make_move(4)
      game.make_move(5)
      game.make_move(8)

      piece_location = game.computer_player.choose_move(game)
      expect(piece_location).to eq(9)
    end

    it "blocks an enemy's possible tic-tac-toe" do
      game.make_move(2)
      game.make_move(1)
      game.make_move(6)
      game.make_move(5)

      piece_location = game.computer_player.choose_move(game)
      expect(piece_location).to eq(9)
    end
  end
end

