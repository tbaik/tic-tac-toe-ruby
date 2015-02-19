require "./lib/gameboard"
require "./lib/human_player"
require "./lib/hard_ai"
require "./lib/medium_ai"
require "./lib/easy_ai"
require "./lib/consoleio"
require "./lib/board_presenter"
require "./lib/winner_presenter"

class TTTGame 
	attr_accessor :game_board, :human_player, :computer_player, :io, :is_player_turn

	def initialize(game_board, human_player, computer_player, io, is_player_turn)
		@game_board = game_board
		@human_player = human_player
    @computer_player = computer_player 
    @io = io
    @is_player_turn = is_player_turn
  end

  def play  
    has_winner = false
    @io.print_message(BoardPresenter.board_string(@game_board.board))

    while(!has_winner && @game_board.num_pieces < @game_board.board.size)
      if is_player_turn
        piece_location = @human_player.choose_move(self)
        make_move(piece_location, @human_player.piece)
      else
        piece_location = @computer_player.choose_move(self)
        make_move(piece_location, @computer_player.piece)
      end
      @io.print_message(BoardPresenter.board_string(@game_board.board))
      has_winner = TTTRules.has_winner(@game_board)
    end
    @io.print_message(WinnerPresenter.winner_string(has_winner, @human_player, @computer_player))
  end

  def make_move(location, piece) 
    @game_board.place_piece(location, piece)
    changeTurn
  end

  def changeTurn
    @is_player_turn = !@is_player_turn
  end

end
