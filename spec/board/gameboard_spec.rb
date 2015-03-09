require_relative "../../lib/ttt_game"
require_relative "../../lib/ttt_rules"
require_relative "../../lib/board/gameboard"

describe GameBoard do
  it 'allows you to initialize with just gb_size' do
    expect{GameBoard.new(3)}.not_to raise_error
  end

  it 'allows you to initialize with 3 parameters' do
    num_pieces = 0
    board = ["1","2","3","4","5","6","7","8","9"]
    valid_moves = [1,2,3,4,5,6,7,8,9] 
    expect{GameBoard.new(num_pieces,board,valid_moves)}.not_to raise_error
	end

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

	describe '#place_piece' do
    let(:gameboard) {GameBoard.new(5)}

    it 'changes the correct index on board' do
      expect(gameboard.board[0]).to eq("1")
      gameboard.place_piece(1,"X")
      expect(gameboard.board[0]).to eq("X")
    end

    it 'adds one piece to num_pieces' do
      expect(gameboard.num_pieces).to eq(0)
      gameboard.place_piece(1,"X")
      expect(gameboard.num_pieces).to eq(1)
    end

    it 'invalidates move' do
      expect(gameboard.valid_moves.include?(1)).to be_truthy 
      gameboard.place_piece(1,"X")
      expect(gameboard.valid_moves.include?(1)).to be_falsey
    end
  end

  describe '#pick_random_move' do
    it 'gives a move from one of the valid moves' do
      gameboard = GameBoard.new(1) 
      expect(gameboard.pick_random_move).to eq(1)
    end

    it 'gives last remaining move' do
      gameboard = GameBoard.new(2)
      gameboard.place_piece(1,"O")
      gameboard.place_piece(3,"X")
      gameboard.place_piece(4,"O")
      expect(gameboard.pick_random_move).to eq(2)
    end
  end

  describe '#board_length' do
    it 'returns the same length of the board as when initialized' do
      gameboard2 = GameBoard.new(2)
      gameboard3 = GameBoard.new(3)
      gameboard5 = GameBoard.new(5)
      expect(gameboard2.board_length).to eq(2)
      expect(gameboard3.board_length).to eq(3)
      expect(gameboard5.board_length).to eq(5)
    end
  end
end
