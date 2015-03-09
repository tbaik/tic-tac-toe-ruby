require_relative '../../lib/ui/output_determiner.rb'
require_relative '../../lib/ui/consoleio'
require_relative '../../lib/ttt_game'

describe OutputDeterminer do
  let(:game) {TTTGame.new(GameBoard.new(3), HumanPlayer.new("X"), HardAI.new("O"), ConsoleIO, true, TTTRules)	}

  describe '#determine_winner_symbol' do
    it 'returns a tie symbol on a tie game' do
      expect(OutputDeterminer.determine_winner_symbol(false, game)).to eq(:winner_tie)
    end

    it 'returns symbol winner_computer for computer win' do
      expect(OutputDeterminer.determine_winner_symbol(true,game)).to eq(:winner_computer)
    end

    it 'returns symbol winner_human_x for X human piece' do
      game.changeTurn
      expect(OutputDeterminer.determine_winner_symbol(true,game)).to eq(:winner_human)
    end
  end

  describe 'determine_piece_placed_symbol' do
    it 'returns symbol placed_human if player placed the piece' do
      expect(OutputDeterminer.determine_piece_placed_symbol(true)).to eq(:placed_human)
    end

    it 'returns symbol placed_computer if computer placed the piece' do
      expect(OutputDeterminer.determine_piece_placed_symbol(false)).to eq(:placed_computer)
    end
  end
end
