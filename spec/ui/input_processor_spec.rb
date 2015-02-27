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
end
