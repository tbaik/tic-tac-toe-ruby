module TTTRules
  class << self
    def is_valid_move?(move, gb)
      gb.valid_moves.include?(move.to_i)
    end

    def opposite_piece(piece)
      return "X" if piece == "O"
      return "O" if piece == "X"
    end

    def has_winner(game_board)
      return false if game_board.num_pieces < ((Math.sqrt(game_board.board.size) * 2) - 1) 
      has_vertical_winner(game_board.board) || has_horizontal_winner(game_board.board) || has_diagonal_winner(game_board.board)
    end

    def has_vertical_winner(board)
      length = Math.sqrt(board.size).to_i	

      length.times do |i|
        num = i
        bool = true
        while num < board.size-length
          if board[num] != board[num+length]	
            bool = false
          end
          num += length
        end
        if bool
          return true
        end
      end
      false
    end

    def has_horizontal_winner(board)
      num = 0
      length = Math.sqrt(board.size).to_i
      while num < board.size
        bool = true 
        (length - 1).times do |i|
          if board[num] != board[num+i+1]
            bool = false	
          end
        end
        if bool
          return true
        else
          num += length
        end
      end
      false
    end

    def has_diagonal_winner(board)
      length = Math.sqrt(board.size).to_i
      num = 0
      bool = true
      while num < board.size - length
        if board[num] != board[num+1+length]
          bool = false
        end
        num += length + 1
      end	
      if bool
        return true
      end

      num = length-1
      bool = true
      while num < board.size - length
        if board[num] != board[num-1+length]
          bool = false
        end
        num += length - 1
      end
      if bool
        return true
      end
      false
    end

    # for computer player's move evaluation. (requires 1 more level of lookahead)
    def has_winner_eval(game_board)
      return false if game_board.num_pieces < ((Math.sqrt(game_board.board.size) * 2) - 1)-1 
      has_vertical_winner(game_board.board) || has_horizontal_winner(game_board.board) || has_diagonal_winner(game_board.board)
    end
  end
end
