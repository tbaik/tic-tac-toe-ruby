class Player
	attr_accessor :is_player_turn
	attr_reader :piece, :opponent_piece

	def initialize(piece, is_player_turn)
		@piece = piece
		if @piece == "O"
			@opponent_piece = "X"
		else
			@opponent_piece = "O"
		end
		@is_player_turn = is_player_turn
	end
	
	def changeTurn
		@is_player_turn = !@is_player_turn
	end
end