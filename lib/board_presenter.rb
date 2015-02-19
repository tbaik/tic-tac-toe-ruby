class BoardPresenter
  class << self
    def board_string(board)
      board_string = ""
      width = Math.sqrt(board.length).to_i
      count = 0

      while count < board.length
        board_string << blank_line_separator(width) 
        values_array = []
        width.times do
          values_array << board[count]
          count = count + 1
        end
        board_string << row_with_values(values_array)
        board_string << blank_line_separator(width)
        board_string << row_separator(width)
      end

      board_string		
    end

    def blank_line_separator(width)
      "     |" * width + "\n" 
    end

    def row_separator(width)
     "------" * width + "\n" 
    end

    def row_with_values(values_array)
      string = ""
      values_array.each do |value|
        string << "  " + value 
        if value.length == 1
          string << "  |"
        else
          string << " |"
        end
      end
      string << "\n"
    end

  end
end
