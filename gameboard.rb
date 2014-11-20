class GameBoard
	attr_reader :board, :num_pieces, :valid_moves, :is_player_turn

	def initialize(is_player_turn)
		@board = []
		@is_player_turn = is_player_turn
		@num_pieces = 0
		@valid_moves = [0,1,2,3,4,5,6,7,8]
		9.times do |i| 
			@board[i] = (i + 1).to_s
		end
	end

	# This is required since cloning alone does shallow copying not deep copying.
	def after_clone
		@board = @board.clone
		@valid_moves = @valid_moves.clone
	end

	# Place a piece on the board / Make a move
	def place_piece(location, who) # int index , string for "O" or "X" 
		@board[location] = who
		@num_pieces += 1
		@valid_moves.delete(location)
		@is_player_turn = !@is_player_turn
	end

	def is_valid_move?(move)
		@valid_moves.include?(move.to_i - 1)
	end
	
	def has_winner
		return false if @num_pieces < 5
		has_vertical_winner || has_horizontal_winner || has_diagonal_winner
	end

	def has_vertical_winner
		3.times do |i|
			if ((@board[i] == @board[i+3]) && (@board[i] == @board[i+6]))
				return true
			end
		end
		false
	end

	def has_horizontal_winner
		num = 0;
		while num < 9
			if ((@board[num] == @board[num+1]) && (@board[num] == @board[num+2]))
				return true
			else
				num += 3;
			end
		end
		false
	end

	def has_diagonal_winner
		(((@board[0] == @board[4]) && (@board[0] == @board[8])) || ((@board[2] == @board[4]) && (@board[2] == @board[6])))
	end

	# Print current board
	def print_board
		puts "     |     |     "
		puts "  " + @board[0] + "  |  " + @board[1] + "  |  " + @board[2]
		puts "     |     |     "
		puts "-----------------"
		puts "     |     |     "
		puts "  " + @board[3] + "  |  " + @board[4] + "  |  " + @board[5]
		puts "     |     |     "
		puts "-----------------"
		puts "     |     |     "
		puts "  " + @board[6] + "  |  " + @board[7] + "  |  " + @board[8]
		puts "     |     |     "
	end
end