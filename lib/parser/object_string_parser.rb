class ObjectStringParser
  @@ALPHABET_REGEX = /[^A-Za-z]/
  @@INTEGER_REGEX = /[^0-9]/
  @@INT_COMMA_WORD_REGEX = /[^0-9,a-zA-Z]/
  @@CLASS_NAME_REGEX = /#<([A-Za-z]+):/
  class << self
    def parse_constant(string)
      Object.const_get(string)
    end

    def parse_boolean(string)
      "true" == string
    end

    def parse_string(str)
      strip_non_word_or_integer_or_comma_characters(str)
    end

    def parse_integer(str)
      strip_non_integer_characters(str).to_i
    end

    def parse_array(str)
      strip_non_word_or_integer_or_comma_characters(str).split(",")
    end

    def parse_class_name(str)
      str.scan(@@CLASS_NAME_REGEX).first.first
    end

    def strip_non_integer_characters(str)
      str.gsub(@@INTEGER_REGEX,"")
    end

    def strip_non_word_or_integer_or_comma_characters(str)
      str.gsub(@@INT_COMMA_WORD_REGEX, "")
    end
  end
end
