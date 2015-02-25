require "./lib/ttt_game"
require "./lib/consoleio"
require "./lib/board/gameboard"
require "./lib/player/human/human_player"
require "./lib/player/ai/hard_ai"
require "./lib/ttt_rules"

describe TTTGame do
	let(:game) do 
		game = TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), TTTUI.new(ConsoleIO), true)	
	end
  
	it 'should initialize with gameboard, human player, computer player, io, and is_player_turn' do
    expect{TTTGame.new(GameBoard.new(4), HumanPlayer.new("O"), HardAI.new("X"), TTTUI.new(ConsoleIO), true)}.not_to raise_error
	end

  describe '#decide_current_player' do
    it 'sets current_player to human_player if is_player_turn' do
      expect(game.current_player).to eq(game.human_player)
    end

    it 'sets current_player to computer_player if is_player_turn is false' do
		  game2 = TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), TTTUI.new(ConsoleIO), false)	
      expect(game2.current_player).to eq(game2.computer_player)
    end
  end

  describe '#changeTurn' do
    it 'changes current player to opposite player' do
      expect(game.current_player).to eq(game.human_player)
      game.changeTurn 
      expect(game.current_player).to eq(game.computer_player)
    end

    it 'changes is_player_turn to opposite boolean' do
      old_turn = game.is_player_turn
      game.changeTurn
      expect(old_turn).to eq(!game.is_player_turn)
    end
  end

  describe '#play' do
    it 'does not get out of loop if no winner until the 9 moves to end in a tie' do
      expect(game.ui).to receive(:print_gameboard).exactly(10).times
      expect(game.ui).to receive(:print_piece_placed).exactly(9).times
      expect(game.ui).to receive(:print_winner).exactly(1).times
      expect(game.human_player).to receive(:choose_move).exactly(5).times.and_return(1,9,8,3,4)
      expect(game.computer_player).to receive(:choose_move).exactly(4).times.and_return(5,2,7,6)
      expect(TTTRules).to receive(:has_winner).exactly(9).times.and_return(false)
      game.play
    end

    it 'gets out of loop if has winner after 6 moves with computer win' do
      expect(game.ui).to receive(:print_gameboard).exactly(7).times
      expect(game.ui).to receive(:print_piece_placed).exactly(6).times
      expect(game.ui).to receive(:print_winner).exactly(1).times
      expect(game.human_player).to receive(:choose_move).exactly(3).times.and_return(1,2,4)
      expect(game.computer_player).to receive(:choose_move).exactly(3).times.and_return(5,3,7)
      expect(TTTRules).to receive(:has_winner).exactly(6).times.and_return(false,false,false,false,false,true)
      game.play
    end

    it 'prints board once in the beginning, once after turn. print once for piece placed, once for winner' do
      new_game = TTTGame.new(GameBoard.new(1), HumanPlayer.new("O"), HardAI.new("X"), TTTUI.new(ConsoleIO), true)
      expect(new_game.ui).to receive(:print_gameboard) 
      expect(new_game.human_player).to receive(:choose_move).and_return(1)
      expect(new_game.ui).to receive(:print_piece_placed)
      expect(new_game.ui).to receive(:print_gameboard) 
      expect(new_game.ui).to receive(:print_winner) 
      new_game.play
    end
  end

  describe '#make_move' do
    let(:new_game) {TTTGame.new(GameBoard.new(3), HumanPlayer.new("O"), HardAI.new("X"), TTTUI.new(ConsoleIO), false)}	

    it 'places piece on the correct spot in the game board ' do
      new_game.make_move(1)
      expect(new_game.game_board.num_pieces).to eq(1)
    end

    it 'changes is_player_turn' do
      old_turn = new_game.is_player_turn
      new_game.make_move(2)
      expect(new_game.is_player_turn).to eq(!old_turn) 
    end
  end
end
