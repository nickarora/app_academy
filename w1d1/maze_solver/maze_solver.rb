class MazeSolver

  attr_accessor :s_coords
  attr_accessor :e_coords

  def initialize(file = "maze.txt")
    @map = read_map(file)
    @s_coords = find_coords('S')
    @e_coords = find_coords('E')
    @shortest = nil
  end

  def read_map(file)
    arr = Array.new
    lines = File.readlines(file).map(&:chomp)
    lines.each do |line|
      arr << line.split("")
    end

    arr
  end

  def show_map
    @map.each do |row|
      puts row.join
    end
  end

  def show_map_with_path(arr_path)
    temp_map = Marshal.load(Marshal.dump(@map))

    arr_path.each do |coords|
      temp_map[coords[0]][coords[1]] = 'X'
    end

    temp_map.each do |row|
      puts row.join
    end
  end


  def find_coords(char)
    start = []
    @map.each_with_index do |row, row_idx|
      row.each_with_index do |map_item, col_idx|
        if map_item == char
          start = [row_idx, col_idx]
        end
      end
    end

    start
    # Reminder: Catch if No char!
  end

  def solve(arr_path_of_coords = [@s_coords], solved = false)

    results = []

    possible_moves = get_next_possible(arr_path_of_coords)

    if solved
      #puts "SOLVED!"
      solution = []
      arr_path_of_coords.each do |coord|
        solution << coord
      end

      if @shortest == nil || @shortest > solution.length
        @shortest = solution.length
      end

      puts "SOLUTION: #{solution}"

      results << solution
    elsif possible_moves.empty? # Trapped!
      #puts "NO MOVES!"
    #otherwise keep recursing
    else
      possible_moves.each do |move|
        #puts "TESTING MOVE: #{move}"
        # Is this move a winning move?
        solved = true if move == @e_coords
        arr_path_of_coords << move

        #show_map_with_path(arr_path_of_coords)
        #sleep(1.0)


        results += solve(arr_path_of_coords, solved) unless @shortest and arr_path_of_coords.length > @shortest
        # puts results.inspect
        # puts "BEFORE: #{arr_path_of_coords}"
        arr_path_of_coords.pop
        # puts "AFTER: #{arr_path_of_coords}"
      end

    end

    results

  end

  def check_direction(row_change, col_change, arr_path)

    current_row = arr_path.last[0]
    current_col = arr_path.last[1]

    if @map[current_row + row_change][current_col + col_change] != nil and
      (@map[current_row + row_change][current_col + col_change] != "*") and
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

maze = MazeSolver.new(ARGV.first)
maze.show_map

puts "Start Coordinates: #{maze.s_coords}"
puts "End Coordinates: #{maze.e_coords}"

arr =  maze.get_next_possible([maze.s_coords])
puts arr.inspect

puts "\n SOLVE:"

solutions = maze.solve
solutions.each do |solution|
  puts solution.inspect
end
