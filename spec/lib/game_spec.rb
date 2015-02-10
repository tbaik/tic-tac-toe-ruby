require "./lib/ttt_game"
require "./lib/gameboard"
require "./lib/human_player"
require "./lib/hard_ai"
require "./lib/ttt_rules"

describe TTTGame do
	let(:game) do 
		game = TTTGame.new(GameBoard.new, HumanPlayer.new("O",true), HardAI.new("X"))	
	end
	it 'should initialize with all parameters' do
		expect(game).not_to be_nil
	end

	describe 'cloning a new game' do
		let(:newgame) do 
			newgame = game.clone
			newgame.after_clone
			newgame
		end

		it 'should have the same variables' do
			newgame.game_board.board.should == game.game_board.board
			newgame.game_board.num_pieces.should == game.game_board.num_pieces
			newgame.human_player.is_player_turn.should == game.human_player.is_player_turn
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
			newgame.make_move(2,"O")
			newgame.game_board.num_pieces.should_not == game.game_board.num_pieces
			newgame.game_board.valid_moves.should_not == game.game_board.valid_moves
			newgame.human_player.is_player_turn.should_not == game.human_player.is_player_turn
		end
	end
end
