require 'ui/input_checker.rb'

describe InputChecker do
  let(:input_checker) {InputChecker}
  describe '#valid_language_input?' do
    it 'returns true on string of 1 or 2 or 3' do
      expect(input_checker.valid_language_input?("1")).to eq(true)
      expect(input_checker.valid_language_input?("2")).to eq(true)
      expect(input_checker.valid_language_input?("3")).to eq(true)
    end

    it 'returns false on other strings' do
      expect(input_checker.valid_language_input?("Q")).to eq(false)
      expect(input_checker.valid_language_input?("4")).to eq(false)
      expect(input_checker.valid_language_input?("")).to eq(false)
    end
  end

  describe '#valid_board_size?' do
    it 'returns true if size is 3,4,5' do
      expect(input_checker.valid_board_size?("3")).to eq(true)
      expect(input_checker.valid_board_size?("4")).to eq(true)
      expect(input_checker.valid_board_size?("5")).to eq(true)
    end

    it 'returns false for any other input' do
      expect(input_checker.valid_board_size?("2")).to eq(false)
      expect(input_checker.valid_board_size?("6")).to eq(false)
      expect(input_checker.valid_board_size?("q")).to eq(false)
    end
  end

  describe '#valid_read_or_new_game_input?' do
    it 'returns true if input is 1 or 2' do
      expect(input_checker.valid_read_or_new_game_input?("1")).to eq(true)
      expect(input_checker.valid_read_or_new_game_input?("2")).to eq(true)
    end

    it 'returns false for other inputs.' do
      expect(input_checker.valid_read_or_new_game_input?("3")).to eq(false)
      expect(input_checker.valid_read_or_new_game_input?("Q")).to eq(false)
      expect(input_checker.valid_read_or_new_game_input?("hello world!")).to eq(false)
    end
  end

  describe '#existing_file_name?' do
    it 'returns true if file exists' do
      File.write("existing_file.txt", "hi!")
      expect(input_checker.existing_file_name?("existing_file.txt")).to eq(true)
      File.delete("existing_file.txt") if File.exist? "existing_file.txt"
    end

    it 'returns false if file does not exist' do
     expect(input_checker.existing_file_name?("non_existant.txt")).to eq(false)
    end
  end

  describe '#valid_file_name?' do
    it 'returns false on empty string' do
      expect(input_checker.valid_file_name?("")).to eq(false)
    end

    it 'returns true if string is not empty' do
      expect(input_checker.valid_file_name?("hello")).to eq(true)
    end
  end
end
