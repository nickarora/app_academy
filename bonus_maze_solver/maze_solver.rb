require_relative 'maze_tree_node'

class NoStartError < ArgumentError
end

class MazeSolver

  MOVEMENTS = [[-1,0], [1,0], [0,-1], [0,1]]

  def initialize(file)
    file ||= 'maze.txt'
    @map = read_map(file)
    @start_pos = find_coords('S')
    @root_node = MazeTreeNode.new(@start_pos)
    @end_pos = nil
    @visited = []
  end

  def solve
    build_tree
    solution = find_path(@end_pos)
    show_map
    show_map_with_solution(solution)
  end

  private
    def inspect
      { :start_pos => @start_pos,
        :end_pos => @end_pos,
        :visited => @visited }.inspect
    end

    def read_map(file)
      arr = Array.new
      lines = File.readlines(file).map(&:chomp)
      lines.each do |line|
        arr << line.split("")
      end

      arr
    end

    def build_tree
      node_queue = [@root_node]

      until node_queue.empty?
        current_node = node_queue.shift
        if self[current_node.pos] == 'E'
          @end_pos = current_node.pos
          break
        end
        new_moves = get_next_possible(current_node.pos)
        new_moves.each do |move|
          new_node = MazeTreeNode.new(move)
          current_node.add_child(new_node)
          node_queue << new_node
          @visited << move
        end
      end

      nil
    end

    def [](pos)
      row, col = pos
      @map[row][col]
    end

    def []=(pos, el)
      row,col = pos
      @map[row][col] = el
    end

    def show_map
      puts "\n\e[31mTHE MAZE\e[0m"
      @map.each do |row|
        puts "\e[31m" + row.join + "\e[0m"
      end

      nil
    end

    def find_coords(char)
      coords = []
      @map.each_with_index do |row, row_idx|
        row.each_with_index do |map_item, col_idx|
          if map_item == char
            coords = [row_idx, col_idx]
          end
        end
      end

      raise NoStartError.new "Invalid Maze File!" if coords.empty?
      
      coords
    end

    def check_direction(row_change, col_change, pos)
      current_row, current_col = pos[0], pos[1]

      if @map[current_row + row_change][current_col + col_change] != nil and
        (@map[current_row + row_change][current_col + col_change] != "*")
        return [current_row + row_change, current_col + col_change]
      end

      return false
    end

    def get_next_possible(pos)
      checks = []
      MOVEMENTS.each do |vert, horiz|
        checks << check_direction(vert, horiz, pos)
      end

      checks.reject { |n| !n || @visited.include?(n) }
    end

    def find_path(end_pos)
       @root_node.bfs(end_pos).trace_path_back.reverse
    end

    def show_map_with_solution(arr_path)
      temp_map = deep_dup(@map)
      arr_path.each { |coords| temp_map[coords[0]][coords[1]] = "\e[32mX\e[0m" }
      temp_map.each { |row| puts row.join }

      nil
    end

    def deep_dup(arr_2d)
      new_arr = []
      arr_2d.each { |row| new_arr << row.dup }
      
      new_arr
    end

end

if __FILE__ == $0
  
  if ARGV.empty?
    maze = MazeSolver.new('maze.txt')
  else
    maze = MazeSolver.new(ARGV.first)
  end

  maze.solve
end