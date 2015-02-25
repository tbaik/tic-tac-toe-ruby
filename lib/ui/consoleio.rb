class ConsoleIO
	class << self	
		def print_message(message)
			puts message
		end

		def get_input
			gets.chomp
		end	
	end
end
