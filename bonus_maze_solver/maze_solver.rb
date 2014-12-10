class MazeSolver

  attr_accessor :s_coords, :e_coords, :map, :solution_lengths

  def initialize(file = "maze.txt")
    @map = read_map(file)
    @s_coords = find_coords('S')
    @e_coords = find_coords('E')
    @solution_lengths = []
  end

  def read_map(file)
    arr = Array.new
    lines = File.readlines(file).map(&:chomp)
    lines.each do |line|
      arr << line.split("")
    end

    arr
  end

  def show_shortest_solution
    show_map
    solutions = solve
    puts "\e[32mSOLUTION\e[0m"
    show_map_with_solution(solutions.min)
    puts "Thanks for using MazeSolver!"
  end

  def show_map
    puts "\n\e[31mTHE MAZE\e[0m"
    map.each do |row|
      puts "\e[31m" + row.join + "\e[0m"
    end
  end

  def show_map_with_solution(arr_path)
    temp_map = deep_dup(map)

    arr_path.each do |coords|
      temp_map[coords[0]][coords[1]] = "\e[32mX\e[0m"
    end

    temp_map.each do |row|
      puts row.join
    end
  end

  def deep_dup(arr_2d)
    new_arr = []

    arr_2d.each do |row|
      new_arr << row.dup
    end

    new_arr
  end

  def find_coords(char)
    coords = []
    map.each_with_index do |row, row_idx|
      row.each_with_index do |map_item, col_idx|
        if map_item == char
          coords = [row_idx, col_idx]
        end
      end
    end

    if coords.empty?
      puts "\e[31mINVALID MAZE INPUT!\e[0m"
      exit(0)
    end

    coords
  end

  def solve(arr_path_of_coords = [@s_coords], solved = false)

    results = []
    possible_moves = get_next_possible(arr_path_of_coords)

    if solved
      solution = deep_dup(arr_path_of_coords)
      solution_lengths << solution.length
      results << solution
    elsif possible_moves.empty? # Trapped.
      results
    elsif solution_lengths.empty? || solution_lengths.min < arr_path_of_coords.length
      possible_moves.each do |move|
        solved = true if move == @e_coords
        arr_path_of_coords << move
        results += solve(arr_path_of_coords, solved)
        arr_path_of_coords.pop
      end
    end

    results
  end

  def check_direction(row_change, col_change, arr_path)

    current_row = arr_path.last[0]
    current_col = arr_path.last[1]

    if map[current_row + row_change][current_col + col_change] != nil and
      (map[current_row + row_change][current_col + col_change] != "*") and
      !arr_path.include?([current_row + row_change,current_col + col_change])
      return [current_row + row_change, current_col + col_change]
    end

    return false
  end

  def get_next_possible(arr_path)
    results = Array.new

    # UP
    up = check_direction(-1,0, arr_path)
    down = check_direction(1,0, arr_path)
    left = check_direction(0,-1, arr_path)
    right = check_direction(0,1, arr_path)

    results << up if up
    results << right if right
    results << down if down
    results << left if left

    results
  end


end

if __FILE__ == $0
  maze = MazeSolver.new(ARGV.first)
  maze.show_shortest_solution
end