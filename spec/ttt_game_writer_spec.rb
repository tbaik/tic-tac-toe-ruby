require 'ttt_game'
require 'gameboard'
require 'hard_ai'
require 'human_player'
require 'ttt_game_writer'

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
end
