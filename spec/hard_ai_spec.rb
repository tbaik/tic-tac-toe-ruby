require 'hard_ai'
require 'ttt_game'

describe HardAI do
  let(:game) {TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), ConsoleIO, false)}
  #O is human, X is computer. X goes first.

  it 'is initialized with piece string' do 
    expect(-> {HardAI.new("X")}).not_to raise_error
  end 

  it 'takes the last position available' do
    game.make_move(1,"X")
    game.make_move(2,"X")
    game.make_move(3,"O")
    game.make_move(4,"O")
    game.make_move(5,"O")
    game.make_move(6,"X")
    game.make_move(7,"X")
    game.make_move(8,"O")
    piece_location = game.computer_player.best_move(game)
    expect(piece_location).to eq(9)
  end

  it "should block an enemy's possible tictactoe" do
    game.make_move(4,"X")
    game.make_move(1,"O")
    game.make_move(9,"X")
    game.make_move(2,"O")

    piece_location = game.computer_player.best_move(game)
    expect(piece_location).to eq(3)
  end

  it 'chooses middle location for at least a tie game' do
    ngame = TTTGame.new(GameBoard.new(3), HumanPlayer.new("X"), HardAI.new("O"), ConsoleIO, true) #X is human, O is computer, X goes first
    ngame.make_move(1,"X") 

    piece_location = ngame.computer_player.best_move(ngame)
    expect(piece_location).to eq(5)
  end
end

