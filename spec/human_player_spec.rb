require 'human_player'
require 'ttt_game'

describe HumanPlayer do
  it 'should have same initial values' do
    player = HumanPlayer.new("O")	
    expect(player.piece).to eq("O")
  end

  describe '#choose_move' do
    it 'returns a piece_location according to user input' do 

    end
    
    it '' do


    end
  end
end



