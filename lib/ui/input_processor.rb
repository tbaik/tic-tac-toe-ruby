require 'player/ai/easy_ai'
require 'player/ai/medium_ai'
require 'player/ai/hard_ai'
require 'ui/pig_latin_translator'
require 'parser/hash_file_parser'

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

    def process_language_input(input)
      case input
      when "1"
        return HashFileParser.parse_file_to_hash(File.expand_path("../../../languages/en_ttt.txt", __FILE__))
      when "2"
        hash = HashFileParser.parse_file_to_hash(File.expand_path("../../../languages/en_ttt.txt", __FILE__))
        hash.each do |key,value|
          hash[key] = PigLatinTranslator.translate_string(value)
        end
        return hash
      when "3"
        return HashFileParser.parse_file_to_hash(File.expand_path("../../../languages/sp_ttt.txt", __FILE__))
      end
    end
  end
end
