require 'readerwriter/ttt_game_reader'
require 'ttt_rules'
require 'ttt_game'
require 'board/gameboard'
require 'player/human/human_player'

class TTTGameCreator
  def initialize(ui)
    @ui = ui
  end

  def new_game
    @ui.receive_and_set_language_choice

    choice = @ui.receive_read_or_new_game
    variables_hash = {}
    if choice == "1"
      variables_hash = new_game_variables 
    else
      variables_hash = read_game_variables
    end

    create_new_game(variables_hash)
  end

  def create_new_game(variables_hash)
    gb = nil
    if variables_hash.has_key?(:gb_size)
      gb = GameBoard.new(variables_hash[:gb_size])
    else
      gb = GameBoard.new(variables_hash[:gb_variables][:num_pieces],
                         variables_hash[:gb_variables][:board],
                         variables_hash[:gb_variables][:valid_moves])
    end
    hp = HumanPlayer.new(variables_hash[:hp_piece])
    cp = variables_hash[:cp_class].new(variables_hash[:cp_piece])
    is_player_turn = variables_hash[:is_player_turn]
    rules = variables_hash[:rules]
    TTTGame.new(gb,hp,cp,@ui,is_player_turn,rules)
  end

  def read_game_variables
    file_name = @ui.receive_read_file_name 
    TTTGameReader.read_game(file_name)
  end

  def new_game_variables
    piece_and_turn = @ui.receive_piece_and_turn
    cp_class = @ui.receive_difficulty
    gb_size = @ui.receive_board_size
    rules = TTTRules
    {:gb_size => gb_size, :hp_piece => piece_and_turn[0],
      :cp_piece => rules.opposite_piece(piece_and_turn[0]), 
      :cp_class => cp_class, :is_player_turn => piece_and_turn[1], :rules => rules}
  end
end
