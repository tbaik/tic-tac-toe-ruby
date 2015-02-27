require 'ttt_game'
require 'ui/consoleio'
require 'ui/input_checker'
require 'ui/input_processor'

describe HardAI do
  let(:game) {TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), TTTUI.new(ConsoleIO, InputProcessor, InputChecker), false, TTTRules)}
  #O is human, X is computer. X goes first.

  it 'is initialized with piece string' do 
    expect(-> {HardAI.new("X")}).not_to raise_error
  end 

  describe '#best_move' do
    it 'takes the last position available' do
      game.make_move(3)
      game.make_move(1)
      game.make_move(4)
      game.make_move(2)
      game.make_move(6)
      game.make_move(5)
      game.make_move(8)
      game.make_move(7)
      piece_location = game.computer_player.best_move(game)
      expect(piece_location).to eq(9)
    end

    it "should block an enemy's possible tictactoe" do
      game.make_move(4)
      game.make_move(1)
      game.make_move(9)
      game.make_move(2)

      piece_location = game.computer_player.best_move(game)
      expect(piece_location).to eq(3)
    end

    it 'chooses middle location for at least a tie game' do
      ngame = TTTGame.new(GameBoard.new(3), HumanPlayer.new("X"), HardAI.new("O"), TTTUI.new(ConsoleIO, InputProcessor, InputChecker), true, TTTRules) #X is human, O is computer, X goes first
      ngame.make_move(1) 

      piece_location = ngame.computer_player.best_move(ngame)
      expect(piece_location).to eq(5)
    end
  end

  describe '#choose_move' do
    it 'calls medium_move when there are more than 9 available spaces' do
      new_game = TTTGame.new(GameBoard.new(4), HumanPlayer.new("X"), HardAI.new("O"), TTTUI.new(ConsoleIO, InputProcessor, InputChecker), true, TTTRules) #X is human, O is computer, X goes first
      expect(new_game.computer_player).to receive(:medium_move)
      new_game.computer_player.choose_move(new_game)
    end

    it 'calls best_move when there are less than 9 available spaces' do
      new_game = TTTGame.new(GameBoard.new(4), HumanPlayer.new("X"), HardAI.new("O"), TTTUI.new(ConsoleIO, InputProcessor, InputChecker), true, TTTRules) #X is human, O is computer, X goes first
      new_game.make_move(1)
      new_game.make_move(2)
      new_game.make_move(3)
      new_game.make_move(4)
      new_game.make_move(5)
      new_game.make_move(6)
      new_game.make_move(7)
      expect(new_game.computer_player).to receive(:best_move)
      new_game.computer_player.choose_move(new_game)
    end
  end

  describe '#get_score' do
    it 'should get a score of 2 if game is winnable with this move' do
      new_game = TTTGame.new(GameBoard.new(3), HumanPlayer.new("X"), HardAI.new("O"), TTTUI.new(ConsoleIO, InputProcessor, InputChecker), true, TTTRules) #X is human, O is computer, X goes first
      new_game.make_move(2)
      new_game.make_move(5)
      new_game.make_move(8)
      expect(new_game.computer_player.get_score(new_game, 3, "O")).to eq(2)
    end

    it 'should get a score of 1 if game is at max a tie with this move' do
      new_game = TTTGame.new(GameBoard.new(3), HumanPlayer.new("X"), HardAI.new("O"), TTTUI.new(ConsoleIO, InputProcessor, InputChecker), true, TTTRules) #X is human, O is computer, X goes first
      new_game.make_move(1)
      expect(new_game.computer_player.get_score(new_game, 5, "O")).to eq(1)
    end

    it 'should get a score of 0 if game leads to a loss with this move' do
      new_game = TTTGame.new(GameBoard.new(3), HumanPlayer.new("X"), HardAI.new("O"), TTTUI.new(ConsoleIO, InputProcessor, InputChecker), true, TTTRules) #X is human, O is computer, X goes first
      new_game.make_move(1)
      expect(new_game.computer_player.get_score(new_game, 2, "O")).to eq(0)
    end
  end
end

