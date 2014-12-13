require './00_tree_node/00_tree_node.rb'

class KnightPathFinder
  attr_reader :start_pos, :move_tree_root
  attr_accessor :visited_positions

  MOVEMENTS = [
    [-2, 1],  # up two right one
    [-2, -1], # up two left one
    [2, 1],   # dpwm two right one
    [2, -1],  # down two left one
    [1, -2],  # up one left two
    [1, 2],   # up one right two
    [-1, -2], # down one left two
    [-1, 2]   # down one right two
  ]

  def initialize(pos = [0, 0])
    @start_pos = pos #pos = [row,col]
    @visited_positions = []
    @move_tree = PolyTreeNode.new(@start_pos)
    build_move_tree
  end

  def build_move_tree
    queue = [@move_tree]

    until queue.empty?
      current_node = queue.shift
      unique_moves = new_move_positions(current_node.value)
      unique_moves.each do |move|
        new_node = PolyTreeNode.new(move)
        current_node.add_child(new_node)
        queue << new_node
      end
    end

    nil
  end

  def find_path(end_pos)
    @move_tree.bfs(end_pos).trace_path_back.reverse
  end

  def new_move_positions(pos)
    all_possible_moves = KnightPathFinder.valid_moves(pos)
    unique_possible_moves = all_possible_moves.reject do |move|
      @visited_positions.include?(move)
    end
    @visited_positions += unique_possible_moves if unique_possible_moves

    unique_possible_moves
  end

  def self.valid_moves(pos)
    row, col = pos

    possible_moves = []

    # Return an array of up to 8 coordinates
    MOVEMENTS.each do |move|
      vertical_movement, horizontal_movement = move
      possible_move = [row + vertical_movement, col + horizontal_movement]
      possible_moves << possible_move if self.move_valid?(possible_move)
    end

    possible_moves
  end

  # returns true if its on the board
  def self.move_valid?(pos)
    row, col = pos
    return false if row < 0 || row > 7
    return false if col < 0 || col > 7
    true
  end
end

if __FILE__ == $PROGRAM_NAME
  k = KnightPathFinder.new
  p k.find_path([7,6])
  p k.find_path([6,2])
end
