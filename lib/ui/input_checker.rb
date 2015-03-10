class InputChecker
  class << self
    def valid_language_input?(input)
      return input == "1" || input == "2" || input == "3"
    end 

    def valid_board_size?(input)
      return input.to_i > 2 && input.to_i < 6 
    end

    def valid_read_or_new_game_input?(input)
      return input == "1" || input == "2"
    end

    def existing_file_name?(input)
      return File.file?(input)
    end

    def valid_file_name?(input)
      return !input.empty? 
    end
  end
end
