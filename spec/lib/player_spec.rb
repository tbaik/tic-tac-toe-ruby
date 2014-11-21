require "spec_helper"
require "player"

describe Player do 
	let(:newPlayer) {Player.new("O",true)}
	it 'should be initialized with correct piece and if its the player turn' do\
		newPlayer.is_player_turn.should be_truthy
		newPlayer.piece.should == "O"
		newPlayer.opponent_piece.should == "X"
	end

	it 'should allow is_player_turn to be negated' do
		newPlayer.changeTurn
		newPlayer.is_player_turn.should be_falsey
	end

end