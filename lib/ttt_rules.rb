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
      length = game_board.board_length.to_i
      return false if game_board.num_pieces < ((length * 2) - 1) 
      has_vertical_winner(game_board.board, length) ||
        has_horizontal_winner(game_board.board, length) ||
        has_diagonal_winner(game_board.board, length)
    end

    def has_vertical_winner(board, length)
      length.times do |column_start_space|
        return true if column_contains_same_pieces?(board, column_start_space, length) 
      end
      return false
    end

    def has_horizontal_winner(board, length)
      row_start_space = 0
      while row_start_space < board.size
        return true if row_contains_same_pieces?(board, row_start_space, length)
        row_start_space += length
      end
      return false
    end

    def has_diagonal_winner(board, length)
      left_diagonal_starting_space = 0
      right_diagonal_starting_space = length - 1
      return diagonal_contains_same_pieces?(board, left_diagonal_starting_space, length+1) ||
        diagonal_contains_same_pieces?(board, right_diagonal_starting_space, length-1)
    end

    def column_contains_same_pieces?(board, column_space, length)
      while column_space < board.size - length
        if board[column_space] != board[column_space+length]
          return false
        end
        column_space += length
      end
      return true
    end

    def row_contains_same_pieces?(board, row_space, length)
      (length - 1).times do
        if board[row_space] != board[row_space+1]
          return false
        end
        row_space += 1
      end
      return true
    end

    def diagonal_contains_same_pieces?(board, diagonal_space, length_to_next_space)
      length = Math.sqrt(board.size)
      while diagonal_space < board.size - length
        if board[diagonal_space] != board[diagonal_space + length_to_next_space]
          return false
        end
        diagonal_space += length_to_next_space
      end
      return true
    end

    # for computer player's move evaluation. (requires 1 more level of lookahead)
    def has_winner_eval(game_board)
      length = game_board.board_length.to_i
      return false if game_board.num_pieces < ((length * 2) - 2) 
      has_vertical_winner(game_board.board, length) ||
        has_horizontal_winner(game_board.board, length) ||
        has_diagonal_winner(game_board.board, length)
    end
  end
end
