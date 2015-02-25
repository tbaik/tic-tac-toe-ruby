require 'ttt_game'
require 'ui/consoleio'


describe HumanPlayer do
  it 'should have same initial values' do
    player = HumanPlayer.new("O")	
    expect(player.piece).to eq("O")
  end

  describe '#choose_move' do
    let(:game) {TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), TTTUI.new(ConsoleIO), true)}	
    
    it 'returns a piece_location according to user input' do 
      expect(game.ui).to receive(:receive_human_turn_choice).and_return("1")
      expect(game.human_player.choose_move(game)).to eq(1) 
    end

    it 'makes you try again if move is not valid' do 
      game.make_move(1)
      expect(game.ui).to receive(:receive_human_turn_choice).and_return("1","2")
      expect(game.human_player.choose_move(game)).to eq(2) 
    end

  end
end



