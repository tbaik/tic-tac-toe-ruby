class EasyAI 
	attr_accessor :piece
	
	def initialize(piece)
		@piece = piece
	end

	def choose_move(game)
		piece_location = game.game_board.valid_moves.sample
		game.make_move(piece_location, @piece)
		ConsoleIO.print_message("Computer places " + @piece + " on " + piece_location.to_s)
	end
end
