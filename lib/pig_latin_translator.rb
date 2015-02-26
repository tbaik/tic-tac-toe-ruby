class PigLatinTranslator
  class << self
    
    def translate_string(string)
      words = string.split(/(\w+)*/) #split by words and punctuations
      sentence = ""
      words.each do |word|
        is_cap = capitalized?(word)
        pig_latin = translate_word(word)
        pig_latin = pig_latin.capitalize if is_cap
        sentence << pig_latin
      end
      sentence
    end

    def translate_word(word)
      return word if not_a_word? word
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

    def not_a_word?(string)
      string.match(/^[[:alpha:]]+$/) == nil ? true : false
    end

    def capitalized?(string)
      string.capitalize == string
    end
  end
end
