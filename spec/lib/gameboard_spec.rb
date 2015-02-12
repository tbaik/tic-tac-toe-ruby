require "spec_helper"
require "ttt_game"
require "ttt_rules"
require "human_player"
require "hard_ai"
require "gameboard"

describe GameBoard do
	describe '3x3 board' do
		let(:gameboard) {GameBoard.new(3)}

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
	describe '4x4 board' do
		let(:gameboard) {GameBoard.new(4)}

		describe 'initializing the gameboard' do
			it 'creates a board with strings 1 through 16' do
				gameboard.board.should == ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"]
			end

			it 'should have no pieces placed' do
				gameboard.num_pieces.should == 0
			end

			it 'should contain all valid moves' do 
				gameboard.valid_moves.should == [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
			end
		end
	end
	describe '5x5 board' do
		let(:gameboard) {GameBoard.new(5)}

		describe 'initializing the gameboard' do
			it 'creates a board with strings 1 through 25' do
				gameboard.board.should == ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25"]
			end

			it 'should have no pieces placed' do
				gameboard.num_pieces.should == 0
			end

			it 'should contain all valid moves' do 
				gameboard.valid_moves.should == [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25]
			end
		end
	end

	it 'allows you to initialize with 3 parameters' do
		gb = GameBoard.new(["1"],0,[1])
		expect(gb).not_to be_nil
	end
end
