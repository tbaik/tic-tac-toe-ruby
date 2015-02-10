class GameBoard
	attr_accessor :board, :num_pieces, :valid_moves

	def initialize(length)
		@board = []
		@num_pieces = 0
		sq_length = length.to_i ** 2
		@valid_moves = (1..sq_length).to_a
		sq_length.times do |i| 
			@board[i] = (i + 1).to_s
		end
	end

	# This is required since cloning alone does shallow copying not deep copying.
	def after_clone
		@board = @board.clone
		@valid_moves = @valid_moves.clone
		return self
	end

	# Place a piece on the board / Make a move
	def place_piece(location, who) # int index , string for "O" or "X" 
		@board[location - 1] = who
		@num_pieces += 1
		@valid_moves.delete(location)
	end	

end
