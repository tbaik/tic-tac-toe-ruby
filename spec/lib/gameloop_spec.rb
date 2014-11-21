require 'spec_helper'
require 'gameloop'

describe GameLoop do
	let(:gb) {GameBoard.new(Player.new("O", false))}
	#O is human, X is computer. X goes first.

	it 'should take the last position available' do
		gb.place_piece(1,"X")
		gb.place_piece(2,"X")
		gb.place_piece(3,"O")
		gb.place_piece(4,"O")
		gb.place_piece(5,"O")
		gb.place_piece(6,"X")
		gb.place_piece(7,"X")
		gb.place_piece(8,"O")
		GameLoop.run_computer(gb)
		gb.board[8].should == "X"
	end

	it 'should block a horizontal tictactoe' do
		gb.place_piece(4,"X")
		gb.place_piece(1,"O")
		gb.place_piece(9,"X")
		gb.place_piece(2,"O")

		GameLoop.run_computer(gb)
		gb.board[2].should == "X"
	end

	it 'should block a vertical tictactoe' do
		gb.place_piece(8,"X")
		gb.place_piece(1,"O")
		gb.place_piece(3,"X")
		gb.place_piece(4,"O")

		GameLoop.run_computer(gb)
		gb.board[6].should == "X"
	end

	it 'should block a diagonal tictactoe' do
		gb.place_piece(8,"X")
		gb.place_piece(1,"O")
		gb.place_piece(3,"X")
		gb.place_piece(5,"O")

		GameLoop.run_computer(gb)
		gb.board[8].should == "X"
	end

	it 'should pick middle location for at least a tie game' do
		ngb = GameBoard.new(Player.new("X", true)) #X is human, O is computer, X goes first
		ngb.place_piece(1,"X") 

		GameLoop.run_computer(ngb)
		ngb.board[4].should == "O"
	end
end