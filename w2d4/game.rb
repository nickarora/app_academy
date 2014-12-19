require 'colorize'
require 'io/console'
require_relative 'errors'
require_relative 'players'
require_relative 'board'
require_relative 'piece'

class CheckersGame

	def initialize
		@cursor = [0,0]
		@board = Board.new
		@human = HumanPlayer.new(@board, :red, @cursor)
		@computer = ComputerPlayer.new(@board, :light_black)
		@current_player = @human
	end

	def play

		until game_over?
			system('clear')
			@board.render(@cursor)
			begin
				more_attacks = @board.move(@current_player.select_move)
			rescue InvalidMoveError => e
				puts e.message.red
				puts "hit any key to continue..."
				STDIN.getch
				retry
			end
			switch_players unless more_attacks
			@board.maybe_promote
		end

		puts "#{game_over?.capitalize} wins!".green

	end

	def game_over?
		return :red if @board.all_color(@board.top_color).empty?
		return :black if @board.all_color(@board.bottom_color).empty?
		false
	end

	def switch_players
		@current_player = @current_player == @human ? @computer : @human
	end
	
end

if __FILENAME__ = $0
	CheckersGame.new.play
end
