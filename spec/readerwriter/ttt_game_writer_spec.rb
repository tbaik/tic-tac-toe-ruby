require_relative '../../lib/ttt_game'
require_relative '../../lib/ui/consoleio'
require_relative '../../lib/readerwriter/ttt_game_writer'
require_relative '../../lib/ui/input_checker'
require_relative '../../lib/ui/input_processor'

describe TTTGameWriter do
  describe '#write_game' do
    it 'writes objects of the game to a given file_name' do
      game = TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), TTTUI.new(ConsoleIO, InputProcessor, InputChecker), true, TTTRules)	
      file_name = "test1.txt"
      TTTGameWriter.write_game(game,file_name)
      expect(File.read("test1.txt")).to eq(game.inspect)

      File.delete("test1.txt") if File.exist?("test1.txt")
    end
  end

  describe '#save_game' do
    it 'writes the game and then exits program' do
      game = TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), TTTUI.new(ConsoleIO, InputProcessor, InputChecker), true, TTTRules)	
      expect(ConsoleIO).to receive(:print_message)
      expect(ConsoleIO).to receive(:get_input).and_return("test2.txt")
      expect{TTTGameWriter.save_game(game)}.to raise_error SystemExit
      File.delete("test2.txt") if File.exist? "test2.txt"
    end
  end
end
