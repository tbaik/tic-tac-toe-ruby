require_relative '../../lib/board/board_presenter'
require_relative '../../lib/board/gameboard'

describe BoardPresenter do
  let(:board) {GameBoard.new(4).board}
  let(:width) {Math.sqrt(board.length).to_i}

  describe '#blank_line_separator' do
    it 'returns width times as many | characters' do
      expect(BoardPresenter.blank_line_separator(width)).to eq("     |     |     |     |\n")
    end
  end
  
  describe '#row_separator' do
    it 'returns 6 spaces of dashes times width' do
      expect(BoardPresenter.row_separator(width)).to eq("------------------------\n")
    end 
  end

  describe '#row_with_values' do
    it 'returns string with correctly separated values and separators' do
      expect(BoardPresenter.row_with_values(["1","2","3","4"])).to eq("  1  |  2  |  3  |  4  |\n")
    end

    it 'makes sure there is still 20 characters with double digit values' do
      expect(BoardPresenter.row_with_values(["1","10","11","12"])).to eq("  1  |  10 |  11 |  12 |\n")
    end
  end

  describe '#board_string' do
    it 'returns correctly spaced out  board' do 
      expect(BoardPresenter.board_string(board)).to eq("     |     |     |     |\n  1  |  2  |  3  |  4  |\n     |     |     |     |\n------------------------\n" + 
                                                       "     |     |     |     |\n  5  |  6  |  7  |  8  |\n     |     |     |     |\n------------------------\n" + 
                                                       "     |     |     |     |\n  9  |  10 |  11 |  12 |\n     |     |     |     |\n------------------------\n" + 
                                                       "     |     |     |     |\n  13 |  14 |  15 |  16 |\n     |     |     |     |\n------------------------\n")
    end
  end
end
