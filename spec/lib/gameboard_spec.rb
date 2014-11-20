require "spec_helper"
require "gameboard"

describe GameBoard do

	let(:gameboard) {GameBoard.new(true)}

	describe 'initializing the gameboard' do
		it 'creates a board with strings 1 through 9' do
			gameboard.board.should == ["1","2","3","4","5","6","7","8","9"]
		end

		it 'should start with player turn' do
			gameboard.is_player_turn.should be_truthy
		end

		it 'should have no pieces placed' do
			gameboard.num_pieces.should == 0
		end

		it 'should contain all valid moves' do 
			gameboard.valid_moves.should == [1,2,3,4,5,6,7,8,9]
		end
	end

	describe 'placing a piece on the game board' do
		it 'should place X on given location' do 
			gameboard.place_piece(1,"X")
			gameboard.board.should == ["X","2","3","4","5","6","7","8","9"]
		end

		it 'should place O on given location' do
			gameboard.place_piece(4,"O")
			gameboard.board.should == ["1","2","3","O","5","6","7","8","9"]
		end

		it 'should increase the number of pieces placed by 1' do 
			prev_num = gameboard.num_pieces
			gameboard.place_piece(2,"O")
			(gameboard.num_pieces - prev_num).should == 1
		end

		it 'should change the turn' do 
			prev_turn = gameboard.is_player_turn
			gameboard.place_piece(2,"O")
			gameboard.is_player_turn.should == !prev_turn
		end

		it 'should change as invalid move' do
			gameboard.is_valid_move?("2").should be_truthy
			gameboard.place_piece(2,"O")
			gameboard.is_valid_move?("2").should be_falsey
		end
	end

	describe 'using is_valid_move' do 
		it 'should return true for valid moves' do
			gameboard.is_valid_move?("2").should be_truthy
		end

		it 'should return false for invalid moves' do
			gameboard.place_piece(1,"O")
			gameboard.is_valid_move?("1").should be_falsey
			gameboard.is_valid_move?("invalid").should be_falsey
			gameboard.is_valid_move?("").should be_falsey
		end
	end

	describe 'cloning a new game board' do
		let(:newboard) do 
			newboard = gameboard.clone
			newboard.after_clone
			newboard
		end

		it 'should have the same variables' do
			newboard.board.should == gameboard.board
			newboard.num_pieces.should == gameboard.num_pieces
			newboard.is_player_turn.should == gameboard.is_player_turn
			newboard.valid_moves.should == gameboard.valid_moves
		end

		it 'should have different object ids' do
			newboard.object_id.should_not == gameboard.object_id
			newboard.board.object_id.should_not == gameboard.board.object_id
			newboard.valid_moves.object_id.should_not == gameboard.valid_moves.object_id
		end
	end

	describe 'checking for winners' do 

		it 'should have horizontal winners row 1' do 
			gameboard.place_piece(1,"O")
			gameboard.place_piece(2,"O")
			gameboard.place_piece(3,"O")
			gameboard.has_horizontal_winner.should be_truthy
		end

		it 'should have horizontal winners row 2' do 
			gameboard.place_piece(4,"X")
			gameboard.place_piece(5,"X")
			gameboard.place_piece(6,"X")
			gameboard.has_horizontal_winner.should be_truthy
		end

		it 'should have horizontal winners row 3' do 
			gameboard.place_piece(7,"O")
			gameboard.place_piece(8,"O")
			gameboard.place_piece(9,"O")
			gameboard.has_horizontal_winner.should be_truthy
		end

		it 'should have vertical winners col 1' do 
			gameboard.place_piece(1,"O")
			gameboard.place_piece(4,"O")
			gameboard.place_piece(7,"O")
			gameboard.has_vertical_winner.should be_truthy
		end

		it 'should have horizontal winners col 2' do 
			gameboard.place_piece(2,"X")
			gameboard.place_piece(5,"X")
			gameboard.place_piece(8,"X")
			gameboard.has_vertical_winner.should be_truthy
		end

		it 'should have horizontal winners col 3' do 
			gameboard.place_piece(3,"O")
			gameboard.place_piece(6,"O")
			gameboard.place_piece(9,"O")
			gameboard.has_vertical_winner.should be_truthy
		end

		it 'should have diagonal winners 1' do 
			gameboard.place_piece(1,"X")
			gameboard.place_piece(5,"X")
			gameboard.place_piece(9,"X")
			gameboard.has_diagonal_winner.should be_truthy
		end

		it 'should have diagonal winners 2' do 
			gameboard.place_piece(3,"O")
			gameboard.place_piece(5,"O")
			gameboard.place_piece(7,"O")
			gameboard.has_diagonal_winner.should be_truthy
		end

		it 'should only have a winner if it has more than five pieces' do
			gameboard.place_piece(1,"O")
			gameboard.place_piece(2,"O")
			gameboard.place_piece(3,"O")
			gameboard.place_piece(4,"X")
			gameboard.has_winner.should_not be_truthy
			gameboard.place_piece(5,"X")
			gameboard.has_winner.should be_truthy
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
			gameboard.has_winner.should_not be_truthy
		end
	end
end