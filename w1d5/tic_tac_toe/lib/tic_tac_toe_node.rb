require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :prev_move_pos, :board, :next_mover_mark

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      return true if @board.won? && @board.winner != evaluator
      return false
    end

    results = []
    children.each do |child|
      results << child.losing_node?(evaluator)
    end
    if evaluator == @next_mover_mark
      return true if results.all?
    else # Opponent's turn
      return true if results.include?(true)
    end

    false
  end

  def winning_node?(evaluator)
    if @board.over?
      return true if @board.winner == evaluator
      return false
    end

    results = []
    children.each do |child|
      results << child.winning_node?(evaluator)
    end
    if evaluator == @next_mover_mark
      return true if results.include?(true)
    else # Opponent's turn
      return true if results.all?
    end

    false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    result = []

    empty_spots = []
    3.times do |row|
      3.times do |col|
        empty_spots << [row, col] if @board.empty?([row, col])
      end
    end

    empty_spots.each do |empty_spot|
      new_board = @board.dup
      new_board[empty_spot] = @next_mover_mark
      result << TicTacToeNode.new(new_board, toggle(@next_mover_mark), empty_spot)
    end

    result
  end

  def toggle(mark)
    mark == :x ? :o : :x
  end

end
