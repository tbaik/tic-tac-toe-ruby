module StringBuilder
	class << self
		def board_string(board)
			board_string = ""
			width = Math.sqrt(board.length).to_i
			count = 0 
			width.times do |i|
				width.times do 
					board_string << "     |"
				end
				board_string << "\n"
				width.times do |j|
					if count < 9 || board[count] == "O" || board[count] == "X"
						board_string << "  " + board[count] + "  |"
					else
						board_string << "  " + board[count] + " |"
					end
					count = count + 1
				end
				board_string << "\n"
				width.times do 
					board_string << "     |" 	
				end
				board_string << "\n"
				width.times do
					board_string << "------"
				end
				board_string << "\n"
			end
			board_string		
		end

		def winner_string(has_winner, num_pieces, human_player, computer_player)
			output_string = ""	
			# We have a winner or a tie!
			if (!has_winner) #tied
				output_string << "It's a tie!"
			else
				if human_player.is_player_turn 
					output_string << "The Computer won as " + computer_player.piece + "!"
				else
					output_string << "Player won as " + human_player.piece + "!"
				end
			end
			output_string << "\n--------------------------------------------------------------"
		end
	end
end
