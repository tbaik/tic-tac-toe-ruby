require 'player/ai/ttt_ai' 
require 'ttt_game' 
require 'consoleio' 

describe TTTAI do
  it 'is initialized with piece' do
    expect{TTTAI.new("O")}.not_to raise_error
  end

  describe '#has_next_ttt' do
    let(:game) {TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), TTTUI.new(ConsoleIO), true)}
    it 'returns true for a move and piece that will give a tictactoe' do
      game.make_move(1) 
      game.make_move(4) 
      game.make_move(2) 
      game.make_move(8) 
      expect(game.computer_player.has_next_ttt(game,3,"O")).to eq(true)
    end

    it 'returns false for a move and piece that does not give a tictactoe' do
      game.make_move(1) 
      game.make_move(4) 
      game.make_move(2) 
      expect(game.computer_player.has_next_ttt(game,3,"X")).to eq(false)
    end 
  end

  describe 'cloning a new game' do
    let(:game) {TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), TTTUI.new(ConsoleIO), false)}
    let(:newgame) do 
      newgame = game.clone
      newgame.computer_player.deep_copy_clone(newgame)
      newgame
    end

    it 'should have the same variables' do
      newgame.game_board.board.should == game.game_board.board
      newgame.game_board.num_pieces.should == game.game_board.num_pieces
      newgame.game_board.valid_moves.should == game.game_board.valid_moves
      newgame.human_player.piece.should == game.human_player.piece
      newgame.computer_player.piece.should == game.computer_player.piece
      newgame.current_player.piece.should == game.current_player.piece
      newgame.is_player_turn.should == game.is_player_turn
    end

    it 'should have different object ids' do
      newgame.object_id.should_not == game.object_id
      newgame.game_board.board.object_id.should_not == game.game_board.board.object_id
      newgame.game_board.valid_moves.object_id.should_not == game.game_board.valid_moves.object_id
      newgame.current_player.object_id.should_not == game.current_player.object_id
    end

    it 'should not change original board after we change newgame variables' do
      newgame.make_move(1)
      newgame.game_board.num_pieces.should_not == game.game_board.num_pieces
      newgame.game_board.valid_moves.should_not == game.game_board.valid_moves
    end
  end

end
