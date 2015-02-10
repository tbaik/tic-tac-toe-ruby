require "ttt_rules"
require "gameboard"
require "hard_ai"
require "ttt_game"

describe TTTRules do 
	let(:gameboard) {GameBoard.new}
	describe 'using is_valid_move' do 
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

	describe 'checking for winners' do 

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

		it 'should have vertical winners col 1' do 
			gameboard.place_piece(1,"O")
			gameboard.place_piece(4,"O")
			gameboard.place_piece(7,"O")
			TTTRules.has_vertical_winner(gameboard.board).should be_truthy
		end

		it 'should have horizontal winners col 2' do 
			gameboard.place_piece(2,"X")
			gameboard.place_piece(5,"X")
			gameboard.place_piece(8,"X")
			TTTRules.has_vertical_winner(gameboard.board).should be_truthy
		end

		it 'should have horizontal winners col 3' do 
			gameboard.place_piece(3,"O")
			gameboard.place_piece(6,"O")
			gameboard.place_piece(9,"O")
			TTTRules.has_vertical_winner(gameboard.board).should be_truthy
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
	
	it 'should give us the opposite piece' do
		expect(TTTRules.opposite_piece("O")).to eq("X")
		expect(TTTRules.opposite_piece("X")).to eq("O")
	end
end

