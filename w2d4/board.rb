class Board

	TOP_COLOR = :light_black
	BOT_COLOR = :red

	def initialize(setup = true)
		make_grid(setup)
	end

	def [](pos)
		row,col = pos
		@grid[row][col]
	end

	def []=(pos, piece)
		row, col = pos
		@grid[row][col] = piece
	end

	def inspect
		nil
	end

	def add_piece(piece, pos)
		raise 'position not empty' unless empty?(pos)
		self[pos] = piece
	end

	def delete_piece(pos)
		self[pos] = nil
	end

	def piece_at(pos)
		self[pos]
	end

	def empty?(pos)
		self[pos].nil?
	end

	def bg_color(r, c, cursor)
		return :green if [r,c] == cursor
		(r+c).odd? ? :blue : :light_blue
	end

	def top_color
		TOP_COLOR
	end

	def bottom_color
		BOT_COLOR
	end

	def render(cursor)
		puts "  0 1 2 3 4 5 6 7"
		@grid.each_with_index do |row, row_index|
			print row_index.to_s + " "
			row.each_with_index do |piece, col_index|
				render_tile(piece, bg_color(row_index, col_index, cursor))
			end
			print "\n"
		end

		nil
	end

	def render_tile(piece, bg)
		print piece.nil? ? "  ".send("on_#{bg}") : piece.render(bg)
	end

	def move(sequence)
		raise InvalidMoveError if piece_at(sequence.first).nil?
		piece_at(sequence.first).perform_moves(sequence)
	end

	def move!(sequence)
		raise InvalidMoveError if piece_at(sequence.first).nil?
		piece_at(sequence.shift).perform_moves!(sequence)
	end

	def valid_pos?(pos)
		pos.all? { |coord| coord.between?(0,7) }
	end

	def all_pieces
		@grid.flatten.compact
	end

	def all_color(color)
		all_pieces.select {|p| p.color == color }
	end

	def cant_attack?(color)
		all_color(color).all? { |p| p.attack_moves.empty? }
	end

	def dup
		new_board = Board.new(false)
		all_pieces.each { |piece| Piece.new(piece.color, new_board, piece.pos, piece.king)}
		new_board
	end

	def maybe_promote
		all_color(BOT_COLOR).each {|p| p.promote if p.pos[0] == 0 }
		all_color(TOP_COLOR).each {|p| p.promote if p.pos[0] == 7 }
	end

	#############################################
	private

	def offset(row)
		row.even? ? 1 : 0		
	end

	def make_grid(setup)
		@grid = Array.new(8){ Array.new(8) {} }
		return unless setup
		
		[ [[0,1,2], TOP_COLOR], [[5,6,7], BOT_COLOR] ].each do | p |
			p[0].each {|row| 4.times {|col| Piece.new(p[1], self, [row, col * 2 + offset(row)] )}}
		end
	end

end