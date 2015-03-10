require 'parser/hash_file_parser.rb'

describe HashFileParser do
  describe '#parse_file_to_hash' do
    it 'parses each line and combines all hashes into one hash of all ui input' do
      hash = HashFileParser.parse_file_to_hash("languages/en_ttt.txt")
      expect(hash[:winner_tie]).to eq("It's a tie")
      expect(hash[:invalid_file_name]).to eq("Invalid file name!")
    end
  end

  describe '#parse_hash_line' do
    it 'creates a hash of symbol key and string value from one line of parsed string' do
      expect(HashFileParser.parse_hash_line("test=random string!")).to eq({:test => "random string!"})
    end
  end
end
