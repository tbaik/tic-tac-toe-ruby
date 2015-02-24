require 'ttt_game'
require 'board/gameboard'
require 'player/ai/hard_ai'
require 'player/human/human_player'
require 'readerwriter/ttt_game_writer'

describe TTTGameWriter do
  describe '#write_game' do
    it 'writes objects of the game to a given file_name' do
      game = TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), ConsoleIO, true)	
      file_name = "test1.txt"
      TTTGameWriter.write_game(game,file_name)
      expect(File.read("test1.txt")).to eq(game.inspect)

      File.delete("test1.txt") if File.exist?("test1.txt")
    end
  end

  describe '#receive_save_file_name' do
    it 'prints message and gets input from with io' do
      io = ConsoleIO
      expect(io).to receive(:print_message) 
      expect(io).to receive(:get_input).and_return("file") 
      file_name = TTTGameWriter.receive_save_file_name(io)
      expect(file_name).to eq("file")
    end

    it 'does not allow blank file names' do
      io = ConsoleIO
      expect(io).to receive(:print_message).exactly(2).times 
      expect(io).to receive(:get_input).and_return("", "file") 
      TTTGameWriter.receive_save_file_name(io)
    end
  end

  describe '#save_game' do
    it 'writes the game and then exits program' do
      game = TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), ConsoleIO, true)	
      expect(ConsoleIO).to receive(:print_message)
      expect(ConsoleIO).to receive(:get_input).and_return("test2.txt")
      expect{TTTGameWriter.save_game(ConsoleIO, game)}.to raise_error SystemExit
      File.delete("test2.txt") if File.exist? "test2.txt"
    end
  end
end
