require './lib/player/ai/easy_ai'
require './lib/player/ai/medium_ai'
require './lib/player/ai/hard_ai'
class InputProcessor
  class << self
    def process_piece_and_turn_input(input)
      case input
      when "1"
        return ["X", true]
      when "2"
        return ["O", false]
      when "3"
        exit
      else
        nil
      end
    end

    def process_difficulty_input(input)
      case input
      when "1"
        EasyAI
      when "2"
        MediumAI
      when "3"
        HardAI
      else
        nil
      end 
    end
  end
end
