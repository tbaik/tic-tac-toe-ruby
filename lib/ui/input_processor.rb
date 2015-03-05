require './lib/player/ai/easy_ai'
require './lib/player/ai/medium_ai'
require './lib/player/ai/hard_ai'
require './lib/ui/pig_latin_translator'

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
        return parse_language_file("languages/en_ttt.txt")
      when "2"
        hash = parse_language_file("languages/en_ttt.txt")
        hash.each do |key,value|
          hash[key] = PigLatinTranslator.translate_string(value)
        end
        return hash
      when "3"
        return parse_language_file("languages/sp_ttt.txt")
      end
    end

    def parse_language_file(file_name)
      hash = {}
      File.open(file_name) do |file|
        while line = file.gets
          hash = hash.merge(parse_hash_line(line)) 
        end
      end
      return hash
    end

    def parse_hash_line(string_line) 
      key_val = string_line.split("=")
      return {key_val[0].to_sym => key_val[1].gsub("\n",'')} 
    end
  end
end
