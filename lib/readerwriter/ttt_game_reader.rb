require 'parser/serialized_object_parser'
require 'parser/object_string_parser'

class TTTGameReader
  class << self
    def read_game(file_name)
      game_objects = SerializedObjectParser.parse_objects(File.read(file_name))
      game_variables_hash = SerializedObjectParser.parse_object_into_hash(game_objects)
      gb_variables = read_game_board_variables(game_variables_hash[:game_board])
      hp_piece = ObjectStringParser.parse_string(game_variables_hash[:human_player][:piece])
      cp_class = read_computer_player_class(game_objects[2])
      is_player_turn = ObjectStringParser.parse_boolean(game_variables_hash[:is_player_turn])
      rules = ObjectStringParser.parse_constant(game_variables_hash[:rules])

      {:gb_variables => gb_variables, :hp_piece => hp_piece,
       :cp_piece => rules.opposite_piece(hp_piece), :cp_class => cp_class,
       :is_player_turn => is_player_turn, :rules => rules}
    end

    def read_game_board_variables(gb_hash)
      board = ObjectStringParser.parse_array(gb_hash[:board])
      num_pieces = ObjectStringParser.parse_integer(gb_hash[:num_pieces])
      valid_moves = ObjectStringParser.parse_array(gb_hash[:valid_moves]).map(&:to_i)
      {:board => board, :num_pieces => num_pieces, :valid_moves => valid_moves}
    end

    def read_computer_player_class(computer_player_object)
      cp_class_string = ObjectStringParser.parse_class_name(computer_player_object)
      return ObjectStringParser.parse_constant(cp_class_string)
    end
  end
end
