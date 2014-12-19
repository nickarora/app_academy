class HumanPlayer

	def initialize(board, color, cursor)
		@board, @color, @cursor = board, color, cursor
	end

	def select_move
		selected = []

  	loop do
      system('clear')
      @board.render(@cursor)
      puts "W,A,S,D to move cursor, SPACE to select to select your sequence"
      puts "When you are ready to move hit Enter."
      puts "Q quits at any time!"
      puts "Selected: #{selected}"
      
      input = STDIN.getch

      case input
      when 'w'
        @cursor[0] -= 1 unless @cursor[0] == 0
      when 'a'
        @cursor[1] -= 1 unless @cursor[1] == 0
      when 's'
        @cursor[0] += 1 unless @cursor[0] == 7
      when 'd'
        @cursor[1] += 1 unless @cursor[1] == 7
      when " "
        selected << @cursor.dup
      when "\r"
      	break
      when 'q'
        exit
      end
    end

    raise InvalidMoveError if @board[selected.first].nil? || @board[selected.first].color != @color
    selected
	end
end

class ComputerPlayer
	def initialize(board, color)
    @board, @color = board, color
	end

  def select_move
    
    piece = nil
    while piece == nil || piece.moves.empty?
      piece = @board.all_color(@color).sample
    end

    [piece.pos, piece.moves.sample]
  end
end