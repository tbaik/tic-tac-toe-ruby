require 'spec_helper'
require 'human_player'
require 'hard_ai'
require 'ttt_game'

	describe HumanPlayer do
		it 'should be created with game piece' do
			player = HumanPlayer.new("O", true)
			expect(player).not_to be_nil
		end

		it 'should have same initial values' do
			player = HumanPlayer.new("O",true)	
			expect(player.piece).to eq("O")
			expect(player.is_player_turn).to eq(true)
		end
	end

	describe EasyAI do
		let(:game) {TTTGame.new(GameBoard.new(3), HumanPlayer.new("O",false), EasyAI.new("X"))}

		it 'is able to choose a move' do
			game.computer_player.choose_move(game)
			expect(game.game_board.num_pieces).to eq(1)
		end

		it 'takes a possible horizontal tic-tac-toe' do
			game.make_move(1,"X")
			game.make_move(4,"O")
			game.make_move(2,"X")
			game.make_move(8,"O")
			game.computer_player.choose_move(game)	
			expect(game.game_board.board[2]).to eq("X")
		end
		it 'takes a possible vertical tic-tac-toe' do
			game.make_move(1,"X")
			game.make_move(2,"O")
			game.make_move(4,"X")
			game.make_move(9,"O")
			game.computer_player.choose_move(game)	
			expect(game.game_board.board[6]).to eq("X")
		end

		it 'takes a possible diagonal tic-tac-toe' do
			game.make_move(1,"X")
			game.make_move(4,"O")
			game.make_move(5,"X")
			game.make_move(8,"O")
			game.computer_player.choose_move(game)	
			expect(game.game_board.board[8]).to eq("X")
		end
	end

	describe MediumAI do
		let(:game) {TTTGame.new(GameBoard.new(3), HumanPlayer.new("O",false), MediumAI.new("X"))}

		it 'blocks horizontal tic-tac-toe.' do
			game.make_move(4,"X")
			game.make_move(1,"O")
			game.make_move(8,"X")
			game.make_move(2,"O")
			game.computer_player.choose_move(game)	
			expect(game.game_board.board[2]).to eq("X")
		end

		it 'blocks vertical tic-tac-toe' do
			game.make_move(2,"X")
			game.make_move(1,"O")
			game.make_move(9,"X")
			game.make_move(4,"O")
			game.computer_player.choose_move(game)	
			expect(game.game_board.board[6]).to eq("X")
		end

		it 'blocks diagonal tic-tac-toe' do
			game.make_move(2,"X")
			game.make_move(1,"O")
			game.make_move(6,"X")
			game.make_move(5,"O")
			game.computer_player.choose_move(game)	
			expect(game.game_board.board[8]).to eq("X")
		end
	end
		
	describe HardAI do
		let(:game) {TTTGame.new(GameBoard.new(3), HumanPlayer.new("O",false), HardAI.new("X"))}
		#O is human, X is computer. X goes first.

		it 'should take the last position available' do
			game.make_move(1,"X")
			game.make_move(2,"X")
			game.make_move(3,"O")
			game.make_move(4,"O")
			game.make_move(5,"O")
			game.make_move(6,"X")
			game.make_move(7,"X")
			game.make_move(8,"O")
			game.computer_player.choose_move(game)
			game.game_board.board[8].should == "X"
		end

		it 'should block a horizontal tictactoe' do
			game.make_move(4,"X")
			game.make_move(1,"O")
			game.make_move(9,"X")
			game.make_move(2,"O")

			game.computer_player.choose_move(game)
			game.game_board.board[2].should == "X"
		end

		it 'should block a vertical tictactoe' do
			game.make_move(8,"X")
			game.make_move(1,"O")
			game.make_move(3,"X")
			game.make_move(4,"O")

			game.computer_player.choose_move(game)
			game.game_board.board[6].should == "X"
		end

		it 'should block a diagonal tictactoe' do
			game.make_move(8,"X")
			game.make_move(1,"O")
			game.make_move(3,"X")
			game.make_move(5,"O")

			game.computer_player.choose_move(game)
			game.game_board.board[8].should == "X"
		end

		it 'should pick middle location for at least a tie game' do
			ngame = TTTGame.new(GameBoard.new(3), HumanPlayer.new("X",true), HardAI.new("O")) #X is human, O is computer, X goes first
			ngame.make_move(1,"X") 

			ngame.computer_player.choose_move(ngame)
			ngame.game_board.board[4].should == "O"
		end
	end
