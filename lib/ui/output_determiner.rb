class OutputDeterminer
  class << self
    def determine_winner_symbol(has_winner, game)
      if(!has_winner)
        return :winner_tie
      else
        if game.is_player_turn
          return :winner_computer 
        else
          return :winner_human 
        end
      end
    end

    def determine_piece_placed_symbol(is_player_turn)
      if is_player_turn
        return :placed_human
      else
        return :placed_computer
      end
    end
  end
end
