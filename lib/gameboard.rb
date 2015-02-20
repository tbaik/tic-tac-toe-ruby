class GameBoard
	attr_accessor :board, :num_pieces, :valid_moves

	def initialize(gb_size_or_num_pieces = 0, board = [], valid_moves = [])
		if board.empty?
			@board = []
			@num_pieces = 0
			sq_length = gb_size_or_num_pieces.to_i ** 2 #gb_size
			@valid_moves = (1..sq_length).to_a
			sq_length.times do |i| 
				@board[i] = (i + 1).to_s
			end
    else
			@board = board
			@num_pieces = gb_size_or_num_pieces #num_pieces
			@valid_moves = valid_moves 
		end
	end

	# Place a piece on the board / Make a move
	def place_piece(location, who) # int index , string for "O" or "X" 
		@board[location - 1] = who
		@num_pieces += 1
		@valid_moves.delete(location)
	end	

  def pick_random_move
    @valid_moves.sample
  end
end
