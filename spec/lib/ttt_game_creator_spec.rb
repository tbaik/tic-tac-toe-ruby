require "ttt_game_creator"


describe TTTGameCreator do
	it 'reads string array object back into normal string array' do
		array = ["1","2","3","4","O","X","7","8","9","10"]
		string = array.inspect
		expect(TTTGameCreator.read_array_object(string).map(&:to_s)).to eq(array)
	end

	it 'reads int array object back into normal int array' do
		array = [1,2,3,4,5]
		string = array.inspect
		expect(TTTGameCreator.read_array_object(string).map(&:to_i)).to eq(array)
	end

	it 'reads game board object string' do
		gb = GameBoard.new(4)
		gb_string = gb.inspect
		new_gb = TTTGameCreator.read_and_create_game_board(gb_string)
		expect(new_gb.board).to eq(gb.board)
		expect(new_gb.num_pieces).to eq(gb.num_pieces)
		expect(new_gb.valid_moves).to eq(gb.valid_moves)
	end

	it 'reads human player object string' do 
		hp = HumanPlayer.new("O",false)
		hp_string = hp.inspect
		new_hp = TTTGameCreator.read_and_create_human_player(hp_string)
		expect(new_hp.piece).to eq(hp.piece)
		expect(new_hp.is_player_turn).to eq(hp.is_player_turn)
	end	

	it 'reads human player object string 2' do 
		hp = HumanPlayer.new("X",true)
		hp_string = hp.inspect
		new_hp = TTTGameCreator.read_and_create_human_player(hp_string)
		expect(new_hp.piece).to eq(hp.piece)
		expect(new_hp.is_player_turn).to eq(hp.is_player_turn)
	end

	it 'reads computer player object string for EasyAI' do
		cp = EasyAI.new("X")
		cp_string = cp.inspect
		new_cp = TTTGameCreator.read_and_create_computer_player(cp_string)
		expect(new_cp.piece).to eq(cp.piece)
		expect(new_cp.class).to eq(cp.class)
	end

	it 'writes objects of the game to a given file_name' do
		game = TTTGame.new(GameBoard.new(3), HumanPlayer.new("O",true), HardAI.new("X"), ConsoleIO)	
		file_name = "test1.txt"
		TTTGameCreator.write_game(game,file_name)
		expect(File.read("test1.txt")).to eq(game.inspect)
	end

	it 'read file given a file_name and create game' do
		game = TTTGame.new(GameBoard.new(3), HumanPlayer.new("O",true), HardAI.new("X"), ConsoleIO)	
		file_name = "test2.txt"
		TTTGameCreator.write_game(game,file_name)
		new_game = TTTGameCreator.read_and_create_game(file_name)
		new_game.game_board.board.should == game.game_board.board
		new_game.game_board.num_pieces.should == game.game_board.num_pieces
		new_game.human_player.is_player_turn.should == game.human_player.is_player_turn
		new_game.game_board.valid_moves.should == game.game_board.valid_moves
		new_game.human_player.piece.should == game.human_player.piece
		new_game.computer_player.piece.should == game.computer_player.piece
	end
end
