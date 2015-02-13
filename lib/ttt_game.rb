require "./lib/gameboard"
require "./lib/string_builder"
require "./lib/human_player"
require "./lib/hard_ai"
require "./lib/medium_ai"
require "./lib/easy_ai"
require "./lib/consoleio"

class TTTGame 
	attr_accessor :game_board, :human_player, :computer_player, :io
	def initialize(game_board, human_player, computer_player, io)
		@game_board = game_board
		@human_player = human_player
		@computer_player = computer_player 
		@io = io
	end

	def play  
		has_winner = false
		@io.print_message(StringBuilder.board_string(@game_board.board))

		while(!has_winner && @game_board.num_pieces < @game_board.board.size)
			if @human_player.is_player_turn == true
				@human_player.choose_move(self)	
			else
				@computer_player.choose_move(self)	
			end
			@io.print_message(StringBuilder.board_string(@game_board.board))
			has_winner = TTTRules.has_winner(@game_board)
		end
		@io.print_message(StringBuilder.winner_string(has_winner, @game_board.num_pieces, @human_player, @computer_player))
	end

	# Place a piece on the board / Make a move
	def make_move(location, who) # int index , string for "O" or "X" 
		@game_board.place_piece(location,who)
		@human_player.changeTurn
	end
end
