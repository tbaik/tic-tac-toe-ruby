require 'ui/consoleio'

describe ConsoleIO do
  describe '#print_message' do
    it 'outputs to stdout the same message we give it' do
      expect{ConsoleIO.print_message("hello world")}.to output("hello world\n").to_stdout
    end
  end
  
  describe '#get_input' do
    it 'returns a string that the user types' do
      skip
    end
  end
end
