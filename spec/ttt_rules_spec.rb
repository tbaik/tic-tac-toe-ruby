require "ttt_rules"
require "board/gameboard"

describe TTTRules do 
  describe '#is_valid_move' do 
    let(:gameboard) {GameBoard.new(3)}

    it 'should return true for valid moves' do
      TTTRules.is_valid_move?("2", gameboard).should be_truthy
    end

    it 'should return false for invalid moves' do
      gameboard.place_piece(1,"O")
      TTTRules.is_valid_move?("1", gameboard).should be_falsey
      TTTRules.is_valid_move?("invalid", gameboard).should be_falsey
      TTTRules.is_valid_move?("", gameboard).should be_falsey
    end

    it 'knows if move is not valid anymore' do
      expect(TTTRules.is_valid_move?("2",gameboard)).to be_truthy
      gameboard.place_piece(2,"O")
      expect(TTTRules.is_valid_move?("2",gameboard)).to be_falsey 
    end
  end

  describe '#opposite_piece' do
    it 'gives back O when given X' do
      expect(TTTRules.opposite_piece("X")).to eq("O")
    end

    it 'gives back X when given O' do 
      expect(TTTRules.opposite_piece("O")).to eq("X")
    end
  end

  describe '#full_board?' do
    let(:gameboard) {GameBoard.new(1)}
    it 'returns true if board has same # of placed pieces as size' do
      gameboard.place_piece(1,"O")
      expect(TTTRules.full_board?(gameboard)).to eq(true)
    end

    it 'returns false if board has less than full' do
      expect(TTTRules.full_board?(gameboard)).to eq(false)
    end
  end

  describe 'checking for winners 3x3' do 
    let(:gameboard) {GameBoard.new(3)}
    it 'should have horizontal winners row 1' do 
      gameboard.place_piece(1,"O")
      gameboard.place_piece(2,"O")
      gameboard.place_piece(3,"O")
      TTTRules.has_horizontal_winner(gameboard.board, gameboard.board_length.to_i).should be_truthy
    end

    it 'should have horizontal winners row 2' do 
      gameboard.place_piece(4,"X")
      gameboard.place_piece(5,"X")
      gameboard.place_piece(6,"X")
      TTTRules.has_horizontal_winner(gameboard.board, gameboard.board_length.to_i).should be_truthy
    end

    it 'should have horizontal winners row 3' do 
      gameboard.place_piece(7,"O")
      gameboard.place_piece(8,"O")
      gameboard.place_piece(9,"O")
      TTTRules.has_horizontal_winner(gameboard.board, gameboard.board_length.to_i).should be_truthy
    end

    it 'should fail non-horizontal' do 
      gameboard.place_piece(7,"O")
      gameboard.place_piece(8,"X")
      gameboard.place_piece(9,"O")
      TTTRules.has_horizontal_winner(gameboard.board, gameboard.board_length.to_i).should be_falsey 
    end

    it 'should have vertical winners col 1' do 
      gameboard.place_piece(1,"O")
      gameboard.place_piece(4,"O")
      gameboard.place_piece(7,"O")
      TTTRules.has_vertical_winner(gameboard.board, gameboard.board_length.to_i).should be_truthy
    end

    it 'should have vertical winners col 2' do 
      gameboard.place_piece(2,"X")
      gameboard.place_piece(5,"X")
      gameboard.place_piece(8,"X")
      TTTRules.has_vertical_winner(gameboard.board, gameboard.board_length.to_i).should be_truthy
    end

    it 'should have vertical winners col 3' do 
      gameboard.place_piece(3,"O")
      gameboard.place_piece(6,"O")
      gameboard.place_piece(9,"O")
      TTTRules.has_vertical_winner(gameboard.board, gameboard.board_length.to_i).should be_truthy
    end

    it 'should fail non-vertical' do 
      gameboard.place_piece(1,"X")
      gameboard.place_piece(4,"O")
      gameboard.place_piece(7,"O")
      TTTRules.has_vertical_winner(gameboard.board, gameboard.board_length.to_i).should be_falsey 
    end

    it 'should have diagonal winners 1' do 
      gameboard.place_piece(1,"X")
      gameboard.place_piece(5,"X")
      gameboard.place_piece(9,"X")
      TTTRules.has_diagonal_winner(gameboard.board, gameboard.board_length.to_i).should be_truthy
    end

    it 'should have diagonal winners 2' do 
      gameboard.place_piece(3,"O")
      gameboard.place_piece(5,"O")
      gameboard.place_piece(7,"O")
      TTTRules.has_diagonal_winner(gameboard.board, gameboard.board_length.to_i).should be_truthy
    end

    it 'should fail diagonal' do 
      gameboard.place_piece(1,"X")
      gameboard.place_piece(5,"O")
      gameboard.place_piece(9,"X")
      TTTRules.has_diagonal_winner(gameboard.board, gameboard.board_length.to_i).should be_falsey 
    end

    it 'should only have a winner if it has more than five pieces' do
      gameboard.place_piece(1,"O")
      gameboard.place_piece(2,"O")
      gameboard.place_piece(3,"O")
      gameboard.place_piece(4,"X")
      TTTRules.has_winner(gameboard).should_not be_truthy
      gameboard.place_piece(5,"X")
      TTTRules.has_winner(gameboard).should be_truthy
    end

    it 'should not have a winner for a tie' do
      gameboard.place_piece(1,"X")
      gameboard.place_piece(2,"X")
      gameboard.place_piece(3,"O")
      gameboard.place_piece(4,"O")
      gameboard.place_piece(5,"O")
      gameboard.place_piece(6,"X")
      gameboard.place_piece(7,"X")
      gameboard.place_piece(8,"O")	
      gameboard.place_piece(9,"X")
      TTTRules.has_winner(gameboard).should_not be_truthy
    end
  end

  describe 'checking for winners 4x4' do 
    let(:gameboard) {GameBoard.new(4)}

    it 'should only have a winner if it has more than seven pieces' do
      gameboard.place_piece(1,"O")
      gameboard.place_piece(2,"O")
      gameboard.place_piece(3,"O")
      gameboard.place_piece(4,"O")
      gameboard.place_piece(5,"X")
      gameboard.place_piece(6,"X")
      TTTRules.has_winner(gameboard).should_not be_truthy
      gameboard.place_piece(7,"X")
      TTTRules.has_winner(gameboard).should be_truthy
    end

    it 'should have horizontal winners' do 
      gameboard.place_piece(13,"O")
      gameboard.place_piece(14,"O")
      gameboard.place_piece(15,"O")
      gameboard.place_piece(16,"O")
      TTTRules.has_horizontal_winner(gameboard.board, gameboard.board_length.to_i).should be_truthy
    end

    it 'should fail non-horizontal' do 
      gameboard.place_piece(1,"X")
      gameboard.place_piece(2,"O")
      gameboard.place_piece(3,"O")
      gameboard.place_piece(4,"O")
      TTTRules.has_horizontal_winner(gameboard.board, gameboard.board_length.to_i).should be_falsey 
    end

    it 'should have vertical winners' do 
      gameboard.place_piece(4,"O")
      gameboard.place_piece(8,"O")
      gameboard.place_piece(12,"O")
      gameboard.place_piece(16,"O")
      TTTRules.has_vertical_winner(gameboard.board, gameboard.board_length.to_i).should be_truthy
    end

    it 'should fail non-vertical' do 
      gameboard.place_piece(2,"X")
      gameboard.place_piece(6,"X")
      gameboard.place_piece(10,"X")
      gameboard.place_piece(14,"O")
      TTTRules.has_vertical_winner(gameboard.board, gameboard.board_length.to_i).should be_falsey
    end

    it 'should have diagonal winners 1' do 
      gameboard.place_piece(1,"X")
      gameboard.place_piece(6,"X")
      gameboard.place_piece(11,"X")
      gameboard.place_piece(16,"X")
      TTTRules.has_diagonal_winner(gameboard.board, gameboard.board_length.to_i).should be_truthy
    end

    it 'should have diagonal winners 2' do 
      gameboard.place_piece(4,"O")
      gameboard.place_piece(7,"O")
      gameboard.place_piece(10,"O")
      gameboard.place_piece(13,"O")
      TTTRules.has_diagonal_winner(gameboard.board, gameboard.board_length.to_i).should be_truthy
    end

    it 'should fail non-diagonal' do 
      gameboard.place_piece(1,"X")
      gameboard.place_piece(6,"X")
      gameboard.place_piece(11,"X")
      gameboard.place_piece(16,"O")
      TTTRules.has_diagonal_winner(gameboard.board, gameboard.board_length.to_i).should be_falsey 
    end

  end

  describe 'checking for winners 5x5' do 
    let(:gameboard) {GameBoard.new(5)}

    it 'should only have a winner if it has more than nine pieces' do
      gameboard.place_piece(1,"O")
      gameboard.place_piece(2,"O")
      gameboard.place_piece(3,"O")
      gameboard.place_piece(4,"O")
      gameboard.place_piece(5,"O")
      gameboard.place_piece(6,"X")
      gameboard.place_piece(7,"X")
      gameboard.place_piece(8,"X")
      TTTRules.has_winner(gameboard).should_not be_truthy
      gameboard.place_piece(9,"X")
      TTTRules.has_winner(gameboard).should be_truthy
    end

    it 'should have horizontal winners' do 
      gameboard.place_piece(6,"X")
      gameboard.place_piece(7,"X")
      gameboard.place_piece(8,"X")
      gameboard.place_piece(9,"X")
      gameboard.place_piece(10,"X")
      TTTRules.has_horizontal_winner(gameboard.board, gameboard.board_length.to_i).should be_truthy
    end

    it 'should fail non-horizontal' do 
      gameboard.place_piece(1,"X")
      gameboard.place_piece(2,"O")
      gameboard.place_piece(3,"O")
      gameboard.place_piece(4,"O")
      gameboard.place_piece(5,"O")
      TTTRules.has_horizontal_winner(gameboard.board, gameboard.board_length.to_i).should be_falsey 
    end

    it 'should have vertical winners' do 
      gameboard.place_piece(2,"X")
      gameboard.place_piece(7,"X")
      gameboard.place_piece(12,"X")
      gameboard.place_piece(17,"X")
      gameboard.place_piece(22,"X")
      TTTRules.has_vertical_winner(gameboard.board, gameboard.board_length.to_i).should be_truthy
    end

    it 'should fail non-vertical' do 
      gameboard.place_piece(2,"X")
      gameboard.place_piece(7,"X")
      gameboard.place_piece(12,"X")
      gameboard.place_piece(17,"O")
      gameboard.place_piece(22,"O")
      TTTRules.has_vertical_winner(gameboard.board, gameboard.board_length.to_i).should be_falsey
    end

    it 'should have diagonal winners 1' do 
      gameboard.place_piece(1,"X")
      gameboard.place_piece(7,"X")
      gameboard.place_piece(13,"X")
      gameboard.place_piece(19,"X")
      gameboard.place_piece(25,"X")
      TTTRules.has_diagonal_winner(gameboard.board, gameboard.board_length.to_i).should be_truthy
    end

    it 'should have diagonal winners 2' do 
      gameboard.place_piece(5,"O")
      gameboard.place_piece(9,"O")
      gameboard.place_piece(13,"O")
      gameboard.place_piece(17,"O")
      gameboard.place_piece(21,"O")
      TTTRules.has_diagonal_winner(gameboard.board, gameboard.board_length.to_i).should be_truthy
    end

    it 'should fail non-diagonal' do 
      gameboard.place_piece(1,"X")
      gameboard.place_piece(7,"X")
      gameboard.place_piece(13,"X")
      gameboard.place_piece(19,"O")
      gameboard.place_piece(25,"O")
      TTTRules.has_diagonal_winner(gameboard.board, gameboard.board_length.to_i).should be_falsey
    end
  end

  describe '#column_contains_same_pieces?' do
    it 'returns true if all spaces of column are same' do
      column = 0
      length = 3
      gameboard = GameBoard.new(3)
      gameboard.place_piece(1, "X")
      gameboard.place_piece(4, "X")
      gameboard.place_piece(7, "X")
      expect(TTTRules.column_contains_same_pieces?(gameboard.board, column, length)).to be_truthy
    end

    it 'returns false if all spaces of column are not the same' do
      column = 0
      length = 3
      gameboard = GameBoard.new(3)
      gameboard.place_piece(1, "X")
      gameboard.place_piece(4, "X")
      gameboard.place_piece(7, "O")
      expect(TTTRules.column_contains_same_pieces?(gameboard.board, column, length)).to be_falsey
    end
  end

  describe '#row_contains_same_pieces?' do
    it 'returns true if all spaces of row are same' do
      row = 0
      length = 3
      gameboard = GameBoard.new(3)
      gameboard.place_piece(1, "O")
      gameboard.place_piece(2, "O")
      gameboard.place_piece(3, "O")
      expect(TTTRules.row_contains_same_pieces?(gameboard.board, row, length)).to be_truthy
    end

    it 'returns false if all spaces of row are not the same' do
      row = 0
      length = 3
      gameboard = GameBoard.new(3)
      gameboard.place_piece(1, "O")
      gameboard.place_piece(2, "O")
      gameboard.place_piece(3, "X")
      expect(TTTRules.row_contains_same_pieces?(gameboard.board, row, length)).to be_falsey
    end
  end

  describe '#diagonal_contains_same_pieces?' do
    it "returns true if left diagonal's spaces are all the same" do
      left_diagonal_starting_space = 0
      length_to_next_space = 4
      gameboard = GameBoard.new(3)
      gameboard.place_piece(1, "O")
      gameboard.place_piece(5, "O")
      gameboard.place_piece(9, "O")
      expect(TTTRules.diagonal_contains_same_pieces?(gameboard.board, left_diagonal_starting_space, length_to_next_space)).to be_truthy
    end

    it "returns false if left diagonal's spaces are not the same" do
      left_diagonal_starting_space = 0
      length_to_next_space = 4
      gameboard = GameBoard.new(3)
      gameboard.place_piece(1, "O")
      gameboard.place_piece(5, "O")
      gameboard.place_piece(9, "X")
      expect(TTTRules.diagonal_contains_same_pieces?(gameboard.board, left_diagonal_starting_space, length_to_next_space)).to be_falsey
    end

    it "returns true if right diagonal's spaces are all the same" do
      right_diagonal_starting_space = 2
      length_to_next_space = 2
      gameboard = GameBoard.new(3)
      gameboard.place_piece(3, "O")
      gameboard.place_piece(5, "O")
      gameboard.place_piece(7, "O")
      expect(TTTRules.diagonal_contains_same_pieces?(gameboard.board, right_diagonal_starting_space, length_to_next_space)).to be_truthy
    end

    it "returns false if right diagonal's spaces are not the same" do
      right_diagonal_starting_space = 2
      length_to_next_space = 2
      gameboard = GameBoard.new(3)
      gameboard.place_piece(3, "O")
      gameboard.place_piece(5, "O")
      gameboard.place_piece(7, "X")
      expect(TTTRules.diagonal_contains_same_pieces?(gameboard.board, right_diagonal_starting_space, length_to_next_space)).to be_falsey
    end
  end

  describe '#has_winner_eval' do
    let(:gameboard) {GameBoard.new(3)}
    it 'should have winner with one less piece' do
      gameboard.place_piece(1,"O")
      gameboard.place_piece(2,"O")
      gameboard.place_piece(3,"O")
      TTTRules.has_winner_eval(gameboard).should_not be_truthy
      gameboard.place_piece(5,"X")
      TTTRules.has_winner_eval(gameboard).should be_truthy
    end
  end
end

