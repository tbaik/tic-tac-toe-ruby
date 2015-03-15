require "player/ai/ttt_ai"

class HardAI < TTTAI
  def initialize(piece)
    super(piece)
  end

  def choose_move(game)
    if (game.game_board.valid_moves.size) < 10
      piece_location = best_move(game)
    else
      piece_location = medium_move(game)
    end
  end

  def best_move(game)
    bestMove = -99
    bestScore = -1
    game.game_board.valid_moves.each do |move|
      score = get_score(game, move, @piece)
      if score > bestScore
        bestScore = score
        bestMove = move
      end
    end
    return bestMove
  end

  def minimax(game)
    has_winner = game.rules.has_winner(game.game_board)
    board_is_full = game.rules.full_board?(game.game_board)
    if (has_winner || board_is_full)
      return game_evaluation(has_winner, game.is_player_turn)
    end

    scores = []
    game.game_board.valid_moves.each do |move|
      scores << get_score(game, move, game.current_player.piece)
    end

    if game.is_player_turn
      return scores.min
    else
      return scores.max
    end
  end

  def game_evaluation(has_winner, is_player_turn)
    if !has_winner
      return 1
    else
      return is_player_turn ? 2 : 0
    end
  end

  def get_score(game, move, piece)
    new_game = game.clone
    deep_copy_clone(new_game)
    new_game.make_move(move)
    minimax(new_game)
  end

  def medium_move(game)
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
