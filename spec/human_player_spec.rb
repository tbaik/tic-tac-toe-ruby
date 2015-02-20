require 'human_player'
require 'ttt_game'

describe HumanPlayer do
  it 'should have same initial values' do
    player = HumanPlayer.new("O")	
    expect(player.piece).to eq("O")
  end

  describe '#choose_move' do
    let(:game) {TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), ConsoleIO, true)}	
    
    it 'returns a piece_location according to user input' do 
      expect(game.io).to receive(:print_message)
      expect(game.io).to receive(:get_input).and_return("1")
      expect(game.human_player.choose_move(game)).to eq(1) 
    end

    it 'makes you try again if move is not valid' do 
      game.make_move(1,"O")
      expect(game.io).to receive(:print_message).exactly(3).times
      expect(game.io).to receive(:get_input).and_return("1","2")
      expect(game.human_player.choose_move(game)).to eq(2) 
    end

    it 'exits on Q' do
      expect(game.io).to receive(:print_message)
      expect(game.io).to receive(:get_input).and_return("Q")
      expect{game.human_player.choose_move(game)}.to raise_error SystemExit         
    end

    it 'writes a file and exits if you choose to save the game' do
      expect(game.io).to receive(:print_message).exactly(2).times
      expect(game.io).to receive(:get_input).and_return("S")
      expect(game.io).to receive(:get_input).and_return("file2.txt")
      expect{game.human_player.choose_move(game)}.to raise_error SystemExit      
      File.delete("file2.txt") if File.exist? "file2.txt"
    end
  end
end



