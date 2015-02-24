require 'setup/new_ttt_receiver'
require 'ttt_game'

describe NewTTTReceiver do
  it 'is initialized with io' do
    expect{NewTTTReceiver.new(ConsoleIO)}.not_to raise_error
  end

  let(:new_receiver) {NewTTTReceiver.new(ConsoleIO)}
  describe '#create_piece_turn_helper' do
    it 'gives us an array of X and true when 1' do
      expect(new_receiver.create_piece_turn_helper("1")).to eq(["X",true])
    end

    it 'gives us an array of O and false when 2' do
      expect(new_receiver.create_piece_turn_helper("2")).to eq(["O",false])
    end

    it 'exits program when 3' do
      expect{new_receiver.create_piece_turn_helper("3")}.to raise_error SystemExit
    end

    it 'gives nil on any other input' do
      expect(new_receiver.create_piece_turn_helper("blah")).to eq(nil)
    end
  end  

  describe '#determine_difficulty' do
    it 'gives back EasyAI when 1' do
      expect(new_receiver.determine_difficulty("1")).to eq(EasyAI)
    end

    it 'gives back MediumAI when 2' do
      expect(new_receiver.determine_difficulty("2")).to eq(MediumAI)
    end

    it 'gives back HardAI when 3' do
      expect(new_receiver.determine_difficulty("3")).to eq(HardAI)
    end

    it 'gives nil on any other input' do
      expect(new_receiver.determine_difficulty("blah")).to eq(nil)
    end
  end

  describe '#receive_difficulty' do
    it 'returns EasyAI on user input 1' do
      expect(new_receiver.io).to receive(:print_message)
      expect(new_receiver.io).to receive(:get_input).and_return("1")
      expect(new_receiver.receive_difficulty).to eq(EasyAI)
    end

    it 'returns MediumAI on user input 2' do
      expect(new_receiver.io).to receive(:print_message)
      expect(new_receiver.io).to receive(:get_input).and_return("2")
      expect(new_receiver.receive_difficulty).to eq(MediumAI)
    end

    it 'returns HardAI on user input 3' do
      expect(new_receiver.io).to receive(:print_message)
      expect(new_receiver.io).to receive(:get_input).and_return("3")
      expect(new_receiver.receive_difficulty).to eq(HardAI)
    end
  end

  describe '#receive_piece_and_turn' do
    it 'returns X and true on user input 1' do
      expect(new_receiver.io).to receive(:print_message)
      expect(new_receiver.io).to receive(:get_input).and_return("1")
      expect(new_receiver.receive_piece_and_turn).to eq(["X",true])
    end

    it 'returns O and false on user input 2' do
      expect(new_receiver.io).to receive(:print_message)
      expect(new_receiver.io).to receive(:get_input).and_return("2")
      expect(new_receiver.receive_piece_and_turn).to eq(["O",false])
    end

    it 'exits on user input 3' do
      expect(new_receiver.io).to receive(:print_message)
      expect(new_receiver.io).to receive(:get_input).and_return("3")
      expect{new_receiver.receive_piece_and_turn}.to raise_error SystemExit
    end
  end

  describe '#receive_board_size' do
    it 'returns same input as given' do
      expect(new_receiver.io).to receive(:print_message)
      expect(new_receiver.io).to receive(:get_input).and_return("4")
      expect(new_receiver.receive_board_size).to eq("4")
    end
  end

  describe '#receive_read_file_name' do
    it 'returns file name if file exists' do
      File.write("test1.txt", "nothing special")
      expect(new_receiver.io).to receive(:print_message)
      expect(new_receiver.io).to receive(:get_input).and_return("test1.txt")
      expect(new_receiver.receive_read_file_name).to eq("test1.txt")
      File.delete("test1.txt") if File.exist?("test1.txt")
    end
  end

  describe '#receive_read_or_new_game' do
    it 'returns 1 on user input 1' do
      expect(new_receiver.io).to receive(:print_message)
      expect(new_receiver.io).to receive(:get_input).and_return("1")
      expect(new_receiver.receive_read_or_new_game).to eq("1")
    end
  end
end
