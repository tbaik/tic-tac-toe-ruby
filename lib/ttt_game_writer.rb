require './lib/ttt_game'

class TTTGameWriter
  class << self
    def write_game(game, file_name)
      game_string = game.inspect
      File.write(file_name, game_string)		
    end
  end
end
