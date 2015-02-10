require "spec_helper"
require "ttt_game"
require "ttt_rules"
require "human_player"
require "hard_ai"
require "gameboard"

describe GameBoard do
	let(:gameboard) {GameBoard.new}

	describe 'initializing the gameboard' do
		it 'creates a board with strings 1 through 9' do
			gameboard.board.should == ["1","2","3","4","5","6","7","8","9"]
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
	end
end
