require "./lib/ttt_rules"
require "./lib/ttt_game"
require "./lib/ttt_game_creator"
require "./lib/new_ttt_receiver"

module GameLoop
	def self.run_ttt_loop
		while(true)
      game_creator = TTTGameCreator.new(NewTTTReceiver.new(ConsoleIO))
			game = game_creator.new_game 
			game.play
		end
	end
end
GameLoop.run_ttt_loop
