require 'winner_presenter'
require 'ttt_game'

describe WinnerPresenter do
  let(:game) {TTTGame.new(GameBoard.new(3), HumanPlayer.new("X"), HardAI.new("O"), ConsoleIO, true)	}

  it 'gives us tie string on a tie game' do 
    expect(WinnerPresenter.winner_string(false, game)).to eq("It's a tie!" + "\n--------------------------------------------------------------") 
  end

  it 'says computer won as the correct piece' do
    expect(WinnerPresenter.winner_string(true, game)).to eq("The Computer won as O!" + "\n--------------------------------------------------------------")
  end

  it 'says player won as the correct piece' do
    game.changeTurn
    expect(WinnerPresenter.winner_string(true, game)).to eq("The Player won as X!" + "\n--------------------------------------------------------------")
  end
end
