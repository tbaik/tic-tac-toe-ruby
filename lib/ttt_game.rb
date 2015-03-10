class TTTGame 
	attr_accessor :game_board, :human_player, :computer_player, :ui, :is_player_turn, :current_player, :rules

	def initialize(game_board, human_player, computer_player, ui, is_player_turn, rules)
		@game_board = game_board
		@human_player = human_player
    @computer_player = computer_player 
    @ui = ui
    @is_player_turn = is_player_turn
    decide_current_player
    @rules = rules
  end

  def play  
    has_winner = false
    @ui.print_gameboard(@game_board.board)

    while(!has_winner && @game_board.num_pieces < @game_board.board.size)
      piece_location = @current_player.choose_move(self)
      @ui.print_piece_placed(@is_player_turn, @current_player.piece, piece_location.to_s)
      make_move(piece_location)
      @ui.print_gameboard(@game_board.board)
      has_winner = rules.has_winner(@game_board)
    end
    @ui.print_winner(has_winner, self)
  end

  def decide_current_player
    if @is_player_turn
      @current_player = @human_player
    else
      @current_player = @computer_player
    end
  end

  def make_move(location) 
    @game_board.place_piece(location, @current_player.piece)
    changeTurn
  end

  def changeTurn
    @is_player_turn = !@is_player_turn
    decide_current_player
  end
end
