require "./lib/ttt_game"
require "./lib/gameboard"
require "./lib/human_player"
require "./lib/hard_ai"
require "./lib/ttt_rules"

describe TTTGame do
	let(:game) do 
		game = TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), ConsoleIO, true)	
	end
  
	it 'should initialize with all parameters' do
		expect(game).not_to be_nil
	end

  describe '#changeTurn' do
    it 'changes is_player_turn to opposite boolean' do
      old_turn = game.is_player_turn
      game.changeTurn
      expect(old_turn).to eq(!game.is_player_turn)
    end
  end

  describe '#make_move' do
    let(:new_game) {TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), ConsoleIO, false)}	

    it 'places piece on the game board and output message' do
      new_game.make_move(2,"X")
      expect(new_game.game_board.num_pieces).to eq(1)
    end

    it 'changes is_player_turn' do
      old_turn = new_game.is_player_turn
      new_game.make_move(2,"X")
      expect(new_game.is_player_turn).to eq(!old_turn) 
    end
  end


  describe 'cloning a new game' do
    let(:newgame) do 
      newgame = game.dup
      newgame.computer_player.deep_copy_clone(newgame)
      newgame
    end

    it 'should have the same variables' do
      newgame.game_board.board.should == game.game_board.board
      newgame.game_board.num_pieces.should == game.game_board.num_pieces
      newgame.game_board.valid_moves.should == game.game_board.valid_moves
      newgame.human_player.piece.should == game.human_player.piece
      newgame.computer_player.piece.should == game.computer_player.piece
    end

    it 'should have different object ids' do
      newgame.object_id.should_not == game.object_id
      newgame.game_board.board.object_id.should_not == game.game_board.board.object_id
      newgame.game_board.valid_moves.object_id.should_not == game.game_board.valid_moves.object_id
      newgame.human_player.object_id.should_not == game.human_player.object_id
    end

    it 'should not change original board after we change newgame variables' do
      newgame.make_move(1,"O")
      newgame.game_board.num_pieces.should_not == game.game_board.num_pieces
      newgame.game_board.valid_moves.should_not == game.game_board.valid_moves
    end
  end
end
