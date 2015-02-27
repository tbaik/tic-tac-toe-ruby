class WinnerPresenter
  class << self
		def winner_string(has_winner, game)
			output_string = ""	
			# We have a winner or a tie!
			if (!has_winner) #tied
				output_string << "It's a tie!"
			else
				if game.is_player_turn 
					output_string << "The Computer won as " + game.computer_player.piece + "!"
				else
					output_string << "The Player won as " + game.human_player.piece + "!"
				end
			end
			output_string << "\n--------------------------------------------------------------"
		end
  end
end
