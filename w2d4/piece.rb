require 'byebug'

class Piece

	UP_DELTAS = 	[ [-1, -1], [-1, 1] ]
	DOWN_DELTAS = [ [ 1, -1], [ 1, 1] ]

	attr_reader :color, :king
	attr_accessor :pos

	def initialize(color, board, pos, king = false)
		@color, @board, @pos, @king = color, board, pos, king
		@board.add_piece(self, pos)
	end

	def symbol
		@king == true ? "★" : "⬤" 
	end

	def promote
		@king = true
	end

	def render(bg_color)
		symbol.send("#{@color}").send("on_#{bg_color}") + " ".send("on_#{bg_color}")
	end

	def dir
		return UP_DELTAS + DOWN_DELTAS if @king
		@color == @board.bottom_color ? UP_DELTAS : DOWN_DELTAS
	end

	def valid_move?(pos)
		return false if pos.nil?
		@board.valid_pos?(pos) && @board.empty?(pos)
	end

	def one_movement(move)
		row, col = @pos
		[row + move[0], col + move[1]]
	end

	def two_movements(move)
		row, col = @pos
		[row + (2 * move[0]), col + (2 * move[1])]		
	end

	def opposing_piece_present?(move)
		return false if valid_move?(one_movement(move))
		return false unless @board.valid_pos?(one_movement(move))
		@board[one_movement(move)].color != @color
	end

	def try_jump(move)
		opposing_piece_present?(move) ? two_movements(move) : nil
	end

	def attack_moves
		dir.map { |move| try_jump(move) }.select { |move| valid_move?(move) }.to_a
	end

	def passive_moves
		dir.map { |move| one_movement(move) }.select { |move| valid_move?(move) }.to_a
	end

	# returns all possible_moves
	def moves
		return passive_moves if attack_moves.empty? && @board.cant_attack?(@color)
		attack_moves 
	end

	def move_possible?(end_pos)
		moves.include? end_pos
	end

	def jumped_piece(s, e)
		[(s[0] + e[0]) / 2, (s[1] + e[1]) / 2]
	end

	def perform_move(end_pos)
		raise InvalidMoveError unless move_possible?(end_pos)
		@board.delete_piece(jumped_piece(@pos, end_pos)) if attack_moves.include? end_pos
		@board[end_pos] = self
		@board.delete_piece(@pos)
		@pos = end_pos
	end

	def valid_move_seq?(seq)
		new_board = @board.dup
		begin 
			new_board.move!(seq)
		rescue InvalidMoveError
			return false
		end

		true
	end

	def perform_moves!(seq)
		raise InvalidMoveError if seq.length > 1 && attack_moves.empty?
		until seq.empty?
			perform_move(seq.shift) 
		end

		nil
	end

	def perform_moves(seq)
		last_move_attack = true if attack_moves.include? seq.last 

		if valid_move_seq?(seq.dup)
			@board.move!(seq)
		else
			raise InvalidMoveError
		end

		last_move_attack && !attack_moves.empty?
	end

end