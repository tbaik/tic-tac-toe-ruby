require './lib/ttt_game'

class TTTGameWriter
  class << self
    def save_game(game)
      file_name = game.ui.receive_save_file_name
      TTTGameWriter.write_game(game, file_name)
      exit
    end

    def write_game(game, file_name)
      game_string = game.inspect
      File.write(file_name, game_string)		
    end
  end
end
