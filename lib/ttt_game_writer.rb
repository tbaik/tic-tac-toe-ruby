require './lib/ttt_game'

class TTTGameWriter
  class << self
    def save_game(io, game)
      file_name = receive_save_file_name(io)
      TTTGameWriter.write_game(game, file_name)
      exit
    end

    def receive_save_file_name(io)
      io.print_message("Please type the name of the save file:")
      file_name = io.get_input
      if file_name != ""	
        return file_name
      else
        receive_save_file_name(io)
      end
    end

    def write_game(game, file_name)
      game_string = game.inspect
      File.write(file_name, game_string)		
    end
  end
end
