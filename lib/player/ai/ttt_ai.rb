require "./lib/player/player"

class TTTAI < Player
  def initialize(piece)
    super(piece)
  end

  def choose_move(game)
  end
 
  def has_next_ttt(game, move, piece) 
		new_game = game.clone
		deep_copy_clone(new_game)
		new_game.game_board.place_piece(move,piece)
		game.rules.has_winner_eval(new_game.game_board)
	end

  def deep_copy_clone(new_game)
		new_game.current_player = new_game.current_player.clone
		new_game.game_board = new_game.game_board.clone
		new_game.game_board.board = new_game.game_board.board.clone
		new_game.game_board.valid_moves = new_game.game_board.valid_moves.clone
		new_game
	end
end
