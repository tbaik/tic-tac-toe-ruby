require 'medium_ai'
require 'ttt_game'

describe MediumAI do
  let(:game) {TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), MediumAI.new("X"), ConsoleIO, false)}

  it 'is initialized with piece string' do 
    expect(-> {MediumAI.new("X")}).not_to raise_error
  end 

  it 'chooses piece location for a possible tic-tac-toe on the next move' do
    game.make_move(1,"X")
    game.make_move(4,"O")
    game.make_move(5,"X")
    game.make_move(8,"O")

    piece_location = game.computer_player.best_move(game)
    expect(piece_location).to eq(9)
  end

  it "blocks an enemy's possible tic-tac-toe" do
    game.make_move(2,"X")
    game.make_move(1,"O")
    game.make_move(6,"X")
    game.make_move(5,"O")

    piece_location = game.computer_player.best_move(game)
    expect(piece_location).to eq(9)
  end
end

