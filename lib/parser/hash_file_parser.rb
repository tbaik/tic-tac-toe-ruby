class HashFileParser
  class << self
    def parse_file_to_hash(file_name)
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
