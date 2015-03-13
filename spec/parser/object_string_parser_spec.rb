require 'parser/object_string_parser'
require 'ttt_rules'
require 'player/ai/hard_ai'

describe ObjectStringParser do
  describe '#parse_constant' do
    it 'returns a constant given a capitalized string' do
      expect(ObjectStringParser.parse_constant("TTTRules")).to eq(TTTRules)
    end
  end

  describe '#parse_boolean' do
    it 'returns true if given true string' do
      expect(ObjectStringParser.parse_boolean("true")).to eq(true)
    end

    it 'returns false if given false string' do
      expect(ObjectStringParser.parse_boolean("false")).to eq(false)
    end
  end

  describe '#parse_string' do
    it 'returns string without all of the extra \" characters' do
      expect(ObjectStringParser.parse_string("\"BLAH123\"")).to eq("BLAH123") 
    end
  end

  describe '#parse_integer' do
    it 'returns an integer from given string' do
      expect(ObjectStringParser.parse_integer("12,.$%#wqr")).to eq(12)
    end
  end

  describe '#parse_array' do
    it 'returns an array with strings back' do
      array = "[\"1\",\"2\"]"
      expect(ObjectStringParser.parse_array(array)).to eq(["1","2"])
    end
  end

  describe '#parse_class_name' do
    it 'reads the name of the saved class' do
      cp = HardAI.new("X")
      string = cp.inspect
      expect(ObjectStringParser.parse_class_name(string)).to eq("HardAI")
    end
  end

  describe '#strip_non_integer_characters' do
    it 'takes out any non integer characters' do
      expect(ObjectStringParser.strip_non_integer_characters("abc12300def,.;$#%!'")).to eq("12300")
    end
  end

  describe '#strip_non_word_or_integer_or_comma_characters' do
    it 'takes out any non word, integer, or comma characters' do
      expect(ObjectStringParser.strip_non_word_or_integer_or_comma_characters("abc,123@#!$")).to eq("abc,123")
    end
  end
end
