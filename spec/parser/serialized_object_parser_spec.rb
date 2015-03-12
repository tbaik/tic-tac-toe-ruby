require 'parser/serialized_object_parser'
require 'ttt_rules'
require 'ttt_game'
require 'board/gameboard'
require 'player/human/human_player'
require 'ui/consoleio'
require 'ui/input_checker'
require 'ui/input_processor'
require 'ui/ttt_ui'

describe SerializedObjectParser do
  describe '#parse_object_into_hash' do
    it 'returns a hash containing each object variable name as key and its values' do
      game = TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), TTTUI.new(ConsoleIO, InputProcessor, InputChecker), true, TTTRules)	
      game_deserialized = SerializedObjectParser.parse_objects(game.inspect)
      game_hash = SerializedObjectParser.parse_object_into_hash(game_deserialized)
      expect(game_hash[:game_board][:valid_moves]).to eq(game.game_board.valid_moves.to_s)
      expect(game_hash[:is_player_turn]).to eq(game.is_player_turn.to_s)
      expect(game_hash[:rules]).to eq(game.rules.to_s)
    end
  end

  describe "#parse_objects" do
    it 'splits out the object strings with variable names in front for both objects with various variables inside and just normal instance variables' do
      game = TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), TTTUI.new(ConsoleIO, InputProcessor, InputChecker), true, TTTRules)	
      game_serialized = game.inspect
      game_deserialized = SerializedObjectParser.parse_objects(game_serialized)
      expect(game_deserialized.first.split("=").first).to eq("@game_board")
      expect(game_deserialized.last.split("=").first).to eq("@rules")
    end
  end

  describe "#parse_object_attributes" do
    it "parses a string as a string within a string" do
      ai_x = HardAI.new("X")
      attributes = SerializedObjectParser.parse_object_attributes("@ai_x=" + ai_x.inspect)
      expect(attributes[:ai_x][:piece]).to eq("\"X\"")
    end

    it 'parses an array as an array inside a string' do
      gameboard = GameBoard.new(4)
      attributes = SerializedObjectParser.parse_object_attributes("@gameboard=" + gameboard.inspect)
      expect(attributes[:gameboard][:valid_moves]).to eq(gameboard.valid_moves.to_s)
    end

    it 'returns a hash of original object with hashes of its instance variables' do
      game = TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), TTTUI.new(ConsoleIO, InputProcessor, InputChecker), true, TTTRules)	
      game_serialized = game.inspect
      game_deserialized = SerializedObjectParser.parse_objects(game_serialized)
      attributes = SerializedObjectParser.parse_object_attributes(game_deserialized[0])
      expect{attributes[:game_board][:num_pieces]}.not_to raise_error
    end
  end

  describe '#parse_attribute_key' do
    it 'returns the name or key of variable' do
      expect(SerializedObjectParser.parse_attribute_key("num_pieces=0")).to eq("num_pieces")
    end
  end

  describe '#parse_attribute_value' do
    it 'returns the raw value if not another object' do
      expect(SerializedObjectParser.parse_attribute_value("num_pieces=123")).to eq("123")
    end

    it 'returns just the first value inside if there is another object as value in same line' do
      value_string = "@is_player_turn=true, @current_player=#<HumanPlayer:0x007fe5ba1e93b0 @piece=\"O\""
      expect(SerializedObjectParser.parse_attribute_value(value_string)).to eq("true")
    end

    it 'returns a hash of the object inside if there is another object as value' do
      value_string = "@current_player=#<HumanPlayer:0x007fe5ba1e93b0 @piece=\"O\""
      expect(SerializedObjectParser.parse_attribute_value(value_string)).to eq({:piece => "\"O\""})
    end
  end

  describe '#first_object_string' do
    it 'is left with the first object, not the name of this class' do
      ai = HardAI.new("X")
      serialized_ai = ai.inspect
      expect(SerializedObjectParser.first_object_string(serialized_ai)).to eq("@piece=\"X\">")
    end
  end

  describe '#cleanup_and_return_value' do
    it 'returns same value if nothing funky attached to it' do
      expect(SerializedObjectParser.cleanup_and_return_value("hello!")).to eq("hello!")
    end

    it 'returns value without comma and space at the end if it has them' do
      expect(SerializedObjectParser.cleanup_and_return_value("hello, ")).to eq("hello")
    end
  end
end
