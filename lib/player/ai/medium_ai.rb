require "player/ai/ttt_ai"

class MediumAI < TTTAI
	def initialize(piece)
		super(piece)
	end

	def choose_move(game)
    piece = @piece
    2.times do
      game.game_board.valid_moves.each do |move|
        if has_next_ttt(game, move, piece) 
          return move
        end
      end
      piece = game.rules.opposite_piece(@piece)
    end
    return game.game_board.pick_random_move 
	end
end
