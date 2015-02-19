class TTTGameCreator
  attr_reader :new_receiver

    def initialize(new_receiver)
      @new_receiver = new_receiver
    end

    def new_game
      choice = @new_receiver.receive_read_or_new_game
      variables_hash = {}
      if choice == "1"
        variables_hash = new_game_variables 
      else
        variables_hash = read_game_variables
      end

      create_new_game(variables_hash)
    end

    def read_game_variables
      file_name = @new_receiver.receive_read_file_name 
      TTTGameReader.read_game(file_name)
    end

    def new_game_variables
      piece_and_turn = @new_receiver.receive_piece_and_turn
      cp_class = @new_receiver.receive_difficulty
      gb_size = @new_receiver.receive_board_size
      {:gb_size => gb_size, :hp_piece => piece_and_turn[0],
      :cp_piece => TTTRules.opposite_piece(piece_and_turn[0]), 
      :cp_class => cp_class, :io => new_receiver.io,
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
      io = variables_hash[:io]
      is_player_turn = variables_hash[:is_player_turn]
      TTTGame.new(gb,hp,cp,io,is_player_turn)
    end
end
