require "ttt_rules"
require "gameboard"
require "hard_ai"
require "ttt_game"
require "ttt_game_creator"

describe TTTRules do 
	describe 'using is_valid_move' do 
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

		it 'should change as invalid move' do
			expect(TTTRules.is_valid_move?("2",gameboard)).to be_truthy
			gameboard.place_piece(2,"O")
			expect(TTTRules.is_valid_move?("2",gameboard)).to be_falsey 
		end

	end

	describe 'checking for winners 3x3' do 
		let(:gameboard) {GameBoard.new(3)}

		it 'should have horizontal winners row 1' do 
			gameboard.place_piece(1,"O")
			gameboard.place_piece(2,"O")
			gameboard.place_piece(3,"O")
			TTTRules.has_horizontal_winner(gameboard.board).should be_truthy
		end

		it 'should have horizontal winners row 2' do 
			gameboard.place_piece(4,"X")
			gameboard.place_piece(5,"X")
			gameboard.place_piece(6,"X")
			TTTRules.has_horizontal_winner(gameboard.board).should be_truthy
		end

		it 'should have horizontal winners row 3' do 
			gameboard.place_piece(7,"O")
			gameboard.place_piece(8,"O")
			gameboard.place_piece(9,"O")
			TTTRules.has_horizontal_winner(gameboard.board).should be_truthy
		end

		it 'should fail non-horizontal' do 
			gameboard.place_piece(7,"O")
			gameboard.place_piece(8,"X")
			gameboard.place_piece(9,"O")
			TTTRules.has_horizontal_winner(gameboard.board).should be_falsey 
		end

		it 'should have vertical winners col 1' do 
			gameboard.place_piece(1,"O")
			gameboard.place_piece(4,"O")
			gameboard.place_piece(7,"O")
			TTTRules.has_vertical_winner(gameboard.board).should be_truthy
		end

		it 'should have vertical winners col 2' do 
			gameboard.place_piece(2,"X")
			gameboard.place_piece(5,"X")
			gameboard.place_piece(8,"X")
			TTTRules.has_vertical_winner(gameboard.board).should be_truthy
		end

		it 'should have vertical winners col 3' do 
			gameboard.place_piece(3,"O")
			gameboard.place_piece(6,"O")
			gameboard.place_piece(9,"O")
			TTTRules.has_vertical_winner(gameboard.board).should be_truthy
		end

		it 'should fail non-vertical' do 
			gameboard.place_piece(1,"X")
			gameboard.place_piece(4,"O")
			gameboard.place_piece(7,"O")
			TTTRules.has_vertical_winner(gameboard.board).should be_falsey 
		end

		it 'should have diagonal winners 1' do 
			gameboard.place_piece(1,"X")
			gameboard.place_piece(5,"X")
			gameboard.place_piece(9,"X")
			TTTRules.has_diagonal_winner(gameboard.board).should be_truthy
		end

		it 'should have diagonal winners 2' do 
			gameboard.place_piece(3,"O")
			gameboard.place_piece(5,"O")
			gameboard.place_piece(7,"O")
			TTTRules.has_diagonal_winner(gameboard.board).should be_truthy
		end

		it 'should fail diagonal' do 
			gameboard.place_piece(1,"X")
			gameboard.place_piece(5,"O")
			gameboard.place_piece(9,"X")
			TTTRules.has_diagonal_winner(gameboard.board).should be_falsey 
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

		it 'should have horizontal winners row 1' do 
			gameboard.place_piece(1,"O")
			gameboard.place_piece(2,"O")
			gameboard.place_piece(3,"O")
			gameboard.place_piece(4,"O")
			TTTRules.has_horizontal_winner(gameboard.board).should be_truthy
		end

		it 'should have horizontal winners row 2' do 
			gameboard.place_piece(5,"X")
			gameboard.place_piece(6,"X")
			gameboard.place_piece(7,"X")
			gameboard.place_piece(8,"X")
			TTTRules.has_horizontal_winner(gameboard.board).should be_truthy
		end

		it 'should have horizontal winners row 3' do 
			gameboard.place_piece(9,"O")
			gameboard.place_piece(10,"O")
			gameboard.place_piece(11,"O")
			gameboard.place_piece(12,"O")
			TTTRules.has_horizontal_winner(gameboard.board).should be_truthy
		end

		it 'should have horizontal winners row 4' do 
			gameboard.place_piece(13,"O")
			gameboard.place_piece(14,"O")
			gameboard.place_piece(15,"O")
			gameboard.place_piece(16,"O")
			TTTRules.has_horizontal_winner(gameboard.board).should be_truthy
		end

		it 'should fail non-horizontal' do 
			gameboard.place_piece(1,"X")
			gameboard.place_piece(2,"O")
			gameboard.place_piece(3,"O")
			gameboard.place_piece(4,"O")
			TTTRules.has_horizontal_winner(gameboard.board).should be_falsey 
		end

		it 'should have vertical winners col 1' do 
			gameboard.place_piece(1,"O")
			gameboard.place_piece(5,"O")
			gameboard.place_piece(9,"O")
			gameboard.place_piece(13,"O")
			TTTRules.has_vertical_winner(gameboard.board).should be_truthy
		end

		it 'should have vertical winners col 2' do 
			gameboard.place_piece(2,"X")
			gameboard.place_piece(6,"X")
			gameboard.place_piece(10,"X")
			gameboard.place_piece(14,"X")
			TTTRules.has_vertical_winner(gameboard.board).should be_truthy
		end

		it 'should have vertical winners col 3' do 
			gameboard.place_piece(3,"O")
			gameboard.place_piece(7,"O")
			gameboard.place_piece(11,"O")
			gameboard.place_piece(15,"O")
			TTTRules.has_vertical_winner(gameboard.board).should be_truthy
		end

		it 'should have vertical winners col 4' do 
			gameboard.place_piece(4,"O")
			gameboard.place_piece(8,"O")
			gameboard.place_piece(12,"O")
			gameboard.place_piece(16,"O")
			TTTRules.has_vertical_winner(gameboard.board).should be_truthy
		end

		it 'should fail non-vertical' do 
			gameboard.place_piece(2,"X")
			gameboard.place_piece(6,"X")
			gameboard.place_piece(10,"X")
			gameboard.place_piece(14,"O")
			TTTRules.has_vertical_winner(gameboard.board).should be_falsey
		end

		it 'should have diagonal winners 1' do 
			gameboard.place_piece(1,"X")
			gameboard.place_piece(6,"X")
			gameboard.place_piece(11,"X")
			gameboard.place_piece(16,"X")
			TTTRules.has_diagonal_winner(gameboard.board).should be_truthy
		end

		it 'should have diagonal winners 2' do 
			gameboard.place_piece(4,"O")
			gameboard.place_piece(7,"O")
			gameboard.place_piece(10,"O")
			gameboard.place_piece(13,"O")
			TTTRules.has_diagonal_winner(gameboard.board).should be_truthy
		end
		
		it 'should fail non-diagonal' do 
			gameboard.place_piece(1,"X")
			gameboard.place_piece(6,"X")
			gameboard.place_piece(11,"X")
			gameboard.place_piece(16,"O")
			TTTRules.has_diagonal_winner(gameboard.board).should be_falsey 
		end

	end

	describe 'checking for winners 5x5' do 
		let(:gameboard) {GameBoard.new(5)}

		it 'should have horizontal winners row 1' do 
			gameboard.place_piece(1,"O")
			gameboard.place_piece(2,"O")
			gameboard.place_piece(3,"O")
			gameboard.place_piece(4,"O")
			gameboard.place_piece(5,"O")
			TTTRules.has_horizontal_winner(gameboard.board).should be_truthy
		end

		it 'should have horizontal winners row 2' do 
			gameboard.place_piece(6,"X")
			gameboard.place_piece(7,"X")
			gameboard.place_piece(8,"X")
			gameboard.place_piece(9,"X")
			gameboard.place_piece(10,"X")
			TTTRules.has_horizontal_winner(gameboard.board).should be_truthy
		end

		it 'should fail non-horizontal' do 
			gameboard.place_piece(1,"X")
			gameboard.place_piece(2,"O")
			gameboard.place_piece(3,"O")
			gameboard.place_piece(4,"O")
			gameboard.place_piece(5,"O")
			TTTRules.has_horizontal_winner(gameboard.board).should be_falsey 
		end

		it 'should have vertical winners col 1' do 
			gameboard.place_piece(1,"O")
			gameboard.place_piece(6,"O")
			gameboard.place_piece(11,"O")
			gameboard.place_piece(16,"O")
			gameboard.place_piece(21,"O")
			TTTRules.has_vertical_winner(gameboard.board).should be_truthy
		end

		it 'should have vertical winners col 2' do 
			gameboard.place_piece(2,"X")
			gameboard.place_piece(7,"X")
			gameboard.place_piece(12,"X")
			gameboard.place_piece(17,"X")
			gameboard.place_piece(22,"X")
			TTTRules.has_vertical_winner(gameboard.board).should be_truthy
		end

		it 'should fail non-vertical' do 
			gameboard.place_piece(2,"X")
			gameboard.place_piece(7,"X")
			gameboard.place_piece(12,"X")
			gameboard.place_piece(17,"O")
			gameboard.place_piece(22,"O")
			TTTRules.has_vertical_winner(gameboard.board).should be_falsey
		end

		it 'should have diagonal winners 1' do 
			gameboard.place_piece(1,"X")
			gameboard.place_piece(7,"X")
			gameboard.place_piece(13,"X")
			gameboard.place_piece(19,"X")
			gameboard.place_piece(25,"X")
			TTTRules.has_diagonal_winner(gameboard.board).should be_truthy
		end

		it 'should have diagonal winners 2' do 
			gameboard.place_piece(5,"O")
			gameboard.place_piece(9,"O")
			gameboard.place_piece(13,"O")
			gameboard.place_piece(17,"O")
			gameboard.place_piece(21,"O")
			TTTRules.has_diagonal_winner(gameboard.board).should be_truthy
		end
		
		it 'should fail non-diagonal' do 
			gameboard.place_piece(1,"X")
			gameboard.place_piece(7,"X")
			gameboard.place_piece(13,"X")
			gameboard.place_piece(19,"O")
			gameboard.place_piece(25,"O")
			TTTRules.has_diagonal_winner(gameboard.board).should be_falsey 
		end

	end

	it 'should give us the opposite piece' do
		expect(TTTRules.opposite_piece("O")).to eq("X")
		expect(TTTRules.opposite_piece("X")).to eq("O")
	end

end

