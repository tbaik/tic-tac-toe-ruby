require './lib/ttt_game'
require './lib/player/human/human_player'

class TTTGameReader 
  class << self

    def read_array_object(array_string)
      array_string.gsub(/[^0-9,a-zA-Z]/,"").split(",")
    end

    def read_game_board_variables(gb_string)
      gb = gb_string.split("@")
      board = read_array_object(gb[1].split("=")[1]).map(&:to_s)
      num_pieces = gb[2].split("=")[1].gsub(/[^0-9]/,"").to_i
      valid_moves = read_array_object(gb[3].split("=")[1]).map(&:to_i)
      {:board => board, :num_pieces => num_pieces, :valid_moves => valid_moves}
    end

    def read_human_player_piece(hp_string)
      hp = hp_string.split("@")
      hp[1].split("=")[1].gsub(/[^OX]/,"") 
    end

    def read_computer_player_class(cp_string)
      cp = cp_string.split("@")
      piece = cp[1].split("=")[1].gsub(/[^OX]/,"") 
      Object.const_get(read_class_name(cp[0]))
    end

    def read_is_player_turn(turn_string)
      "true" == read_line_for_words(turn_string.split("@")[-2])
    end

    def read_game(file_name)
      game_string = File.read(file_name).split("#")
      gb_variables = read_game_board_variables(game_string[2])
      hp_piece = read_human_player_piece(game_string[3])
      cp_class = read_computer_player_class(game_string[4])
      is_player_turn = read_is_player_turn(game_string[5])
      rules = read_rules(game_string[6])
      {:gb_variables => gb_variables, :hp_piece => hp_piece, 
        :cp_piece => rules.opposite_piece(hp_piece), :cp_class => cp_class,
        :is_player_turn => is_player_turn, :rules => rules} 
    end

    def read_line_for_words(string)
      string.split("=")[1].gsub(/[^A-Za-z]/,"") 
    end

    def read_rules(string)
      Object.const_get(read_line_for_words(string.split("@")[2]))
    end

    def read_class_name(str)
      str.split(":")[0].gsub(/[^A-Za-z]/,"") 
    end
  end
end
