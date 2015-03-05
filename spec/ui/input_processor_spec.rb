require 'ui/input_processor'
describe InputProcessor do
  describe '#process_piece_and_turn_input' do
    it 'returns X as piece and true for turn when given 1' do
      expect(InputProcessor.process_piece_and_turn_input("1")).to eq(["X",true])
    end 

    it 'returns O as piece and false for turn when given 2' do
      expect(InputProcessor.process_piece_and_turn_input("2")).to eq(["O",false])
    end
    
    it 'exits when given 3' do
      expect{InputProcessor.process_piece_and_turn_input("3")}.to raise_error SystemExit
    end

    it 'returns nil on any other input' do
      expect(InputProcessor.process_piece_and_turn_input("nothing")).to eq(nil)
    end
  end

  describe '#process_difficulty_input' do
    it 'returns EasyAI when given 1' do
      expect(InputProcessor.process_difficulty_input("1")).to eq(EasyAI)
    end

    it 'returns MediumAI when given 1' do
      expect(InputProcessor.process_difficulty_input("2")).to eq(MediumAI)
    end

    it 'returns HardAI when given 1' do
      expect(InputProcessor.process_difficulty_input("3")).to eq(HardAI)
    end

    it 'returns nil on any other input' do
      expect(InputProcessor.process_difficulty_input("whatever_input")).to eq(nil)
    end
  end

  describe '#process_language_input' do
    it 'returns a hash of parsed ttt ui input for english text when given 1' do
      hash = InputProcessor.process_language_input("1")
      expect(hash[:winner_tie]).to eq("It's a tie")
    end
    
    it 'returns a hash of pig latin ttt ui given 2' do
      hash = InputProcessor.process_language_input("2")
      expect(hash[:winner_tie]).to eq("Itway'say away ietay")
    end
    
    it 'returns a hash of spanish ttt ui given 3' do
      hash = InputProcessor.process_language_input("3")
      expect(hash[:winner_tie]).to eq("Es un empate")
    end
  end

  describe '#parse_language_file' do
    it 'parses each line and combines all hashes into one hash of all ui input' do
      hash = InputProcessor.parse_language_file("languages/en_ttt.txt")
      expect(hash[:winner_tie]).to eq("It's a tie")
      expect(hash[:invalid_file_name]).to eq("Invalid file name!")
    end
  end

  describe '#parse_hash_line' do
    it 'creates a hash of symbol key and string value from one line of parsed string' do
      expect(InputProcessor.parse_hash_line("test=random string!")).to eq({:test => "random string!"})
    end
  end
end
