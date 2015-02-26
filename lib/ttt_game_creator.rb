require './lib/readerwriter/ttt_game_reader'
require './lib/ttt_rules'
require './lib/ttt_game'
require './lib/pig_latin_translator'

class TTTGameCreator
  attr_reader :ui

  def initialize(ui)
    @ui = ui
  end

  def new_game
    language_choice = @ui.receive_language_choice
    if language_choice == "2"
      @ui.translate(PigLatinTranslator)
    end

    choice = @ui.receive_read_or_new_game
    variables_hash = {}
    if choice == "1"
      variables_hash = new_game_variables 
    else
      variables_hash = read_game_variables
    end

    create_new_game(variables_hash)
  end

  def read_game_variables
    file_name = @ui.receive_read_file_name 
    TTTGameReader.read_game(file_name)
  end

  def new_game_variables
    piece_and_turn = @ui.receive_piece_and_turn
    cp_class = @ui.receive_difficulty
    gb_size = @ui.receive_board_size
    {:gb_size => gb_size, :hp_piece => piece_and_turn[0],
      :cp_piece => TTTRules.opposite_piece(piece_and_turn[0]), 
      :cp_class => cp_class, :io => @ui.io,
      :is_player_turn => piece_and_turn[1]}
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
    TTTGame.new(gb,hp,cp,@ui,is_player_turn)
  end
end
