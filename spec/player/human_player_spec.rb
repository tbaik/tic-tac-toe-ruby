require 'ttt_rules'
require 'ttt_game'
require 'board/gameboard'
require 'player/human/human_player'
require 'ui/consoleio'
require 'ui/input_checker'
require 'ui/input_processor'
require 'ui/ttt_ui'

describe HumanPlayer do
  let(:game) {TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), TTTUI.new(ConsoleIO, InputProcessor, InputChecker), true, TTTRules)}	
  let(:player) {HumanPlayer.new("O")}
  it 'should have same initial values' do
    expect(player.piece).to eq("O")
  end

  describe '#choose_move' do
    it 'returns a piece_location according to user input' do 
      expect(game.ui).to receive(:receive_human_turn_choice).and_return("1")
      expect(game.human_player.choose_move(game)).to eq(1) 
    end

    it 'makes you try again if move is not valid' do 
      game.make_move(1)
      expect(game.ui).to receive(:receive_human_turn_choice).and_return("1","2")
      expect(game.ui.io).to receive(:print_message)
      expect(game.human_player.choose_move(game)).to eq(2) 
    end

    it 'exits on Q' do
      expect(game.ui.io).to receive(:print_message)
      expect(game.ui.io).to receive(:get_input).and_return("Q")
      expect{game.human_player.choose_move(game)}.to raise_error SystemExit         
    end

    it 'writes a file and exits if you choose to save the game' do
      expect(game.ui.io).to receive(:print_message).exactly(2).times
      expect(game.ui.io).to receive(:get_input).and_return("S")
      expect(game.ui.io).to receive(:get_input).and_return("file2.txt")
      expect{game.human_player.choose_move(game)}.to raise_error SystemExit      
      File.delete("file2.txt") if File.exist? "file2.txt"
    end
  end

  describe '#command?' do
    it 'returns true if string is Q or S' do
      expect(player.command?("Q")).to eq(true)
      expect(player.command?("S")).to eq(true)
    end
  end

  describe '#process_command' do
    it 'exits if Q' do
      expect{game.human_player.process_command("Q", game)}.to raise_error SystemExit
    end

    it 'writes a file and exits if S' do
      expect(game.ui.io).to receive(:print_message)
      expect(game.ui.io).to receive(:get_input).and_return("file2.txt")
      expect{game.human_player.process_command("S", game)}.to raise_error SystemExit
      File.delete("file2.txt") if File.exist? "file2.txt"
    end
  end
end
