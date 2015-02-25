class PigLatinTranslator
  class << self
    
    def translate_string(string)
      words = string.split(/(\w+([-'.]\w+)*)/) #split by words and punctuations
      sentence = ""
      words.each do |word|
        is_cap = is_capitalized?(word)
        pig_latin = translate_word(word)
        pig_latin = pig_latin.capitalize if is_cap
        sentence << pig_latin
      end
      sentence
    end

    def translate_word(word)
      return word if is_not_a_word? word
      start_with_vowel?(word) ? translate_vowel_word(word) : translate_consonant_word(word)
    end

    def start_with_vowel?(string)
      string =~ /^[aeiou]/i ? true : false
    end

    def translate_vowel_word(word)
      word << "way"
    end

    def translate_consonant_word(word)
      starting_consonants = word.slice!(/[^aeiou]*/i)
      word + starting_consonants.downcase + "ay"
    end

    def is_integer?(string)
      string.to_i.to_s == string
    end

    def is_punctuation?(string)
      string =~ /^[,.!?;:'"]/i ? true : false  
    end

    def is_not_a_word?(string)
      (is_integer? string) || (is_punctuation? string) || string.empty? || string == " " || string == "\n"
    end

    def is_capitalized?(string)
      string.capitalize == string
    end
  end
end
