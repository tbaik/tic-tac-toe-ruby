require_relative '../../lib/ui/pig_latin_translator'

describe PigLatinTranslator do
  let(:plt) {PigLatinTranslator}
  describe '#translate_string' do
    it 'returns a string with translated piglatin given just words' do
      sentence = "hello my name is tony" 
      expect(plt.translate_string(sentence)).to eq("ellohay myay amenay isway onytay")
    end

    it 'returns piglatin with punctuation with punctuation at end of string' do
      string = "hello,"
      expect(plt.translate_string(string)).to eq("ellohay,")
    end

    it 'returns piglatin with words capitalized if they came capitalized' do
      sentence = "Hello this Is A capital Test"
      expect(plt.translate_string(sentence)).to eq("Ellohay isthay Isway Away apitalcay Esttay")
    end
  end
  
  describe '#translate_word' do
    it 'returns numbers as is' do
      string = "123" 
      expect(plt.translate_word(string)).to eq("123")
    end

    it 'returns with -way at the end if word starts with a vowel' do
      string = "elmo"
      expect(plt.translate_word(string)).to eq("elmoway")
    end

    it 'returns with consonant translation if word starts with consonants' do
      string = "glove"
      expect(plt.translate_word(string)).to eq("oveglay")
    end

    it 'returns punctuation as is' do
      string = "!"
      expect(plt.translate_word(string)).to eq("!")
    end
  end

  describe '#start_with_vowel?' do
    it 'returns true if string starts with a vowel character' do
      string = "elmo" 
      expect(plt.start_with_vowel?(string)).to eq(true)
    end
    it 'returns true if string starts with a capital vowel' do
      string = "Ello"
      expect(plt.start_with_vowel?(string)).to eq(true)
    end

    it 'returns false if string starts with a consonant' do
      string = "Hello"
      expect(plt.start_with_vowel?(string)).to eq(false)
    end
  end

  describe '#translate_vowel_word' do
    it 'adds way to the end of word' do
      string = "ello"
      expect(plt.translate_vowel_word(string)).to eq("elloway")
    end 
  end

  describe '#translate_consonant_word' do
    it 'adds first letter of word and ay to the end of word' do
      string = "hello"
      expect(plt.translate_consonant_word(string)).to eq("ellohay")
    end
    
    it 'adds the starting consonants of word (until a vowel) and ay to the end of word' do
      string = "string"
      expect(plt.translate_consonant_word(string)).to eq("ingstray")
    end

    it 'downcases the starting consonant before adding to end' do
      string = "String"
      expect(plt.translate_consonant_word(string)).to eq("ingstray")
    end
  end

  describe '#not_a_word?' do
    it 'returns true for integer' do
      string = "123"
      expect(plt.not_a_word?(string)).to eq(true)
    end  

    it 'returns true for punctuation' do
      string = ","
      expect(plt.not_a_word?(string)).to eq(true)
    end

    it 'returns true for empty string' do
      string = ""
      expect(plt.not_a_word?(string)).to eq(true)
      string = " "
      expect(plt.not_a_word?(string)).to eq(true)
    end

    it 'returns true for next line character' do
      string = "\n"
      expect(plt.not_a_word?(string)).to eq(true)
    end
  end

  describe '#capitalized?' do
    it 'returns true if string is capitalized' do
      string = "Hello"
      expect(plt.capitalized?(string)).to eq(true)
    end
  end
end
