class Game

  attr_accessor :game, :player, :computer

  def initialize
    @game = Board.new
    marks = get_marks
    @player = HumanPlayer.new(marks[0], game)
    @computer = ComputerPlayer.new(marks[1], game)
  end

  def get_marks
    player_mark = nil
    computer_mark = nil

    loop do
      puts "Would you prefer X or O?"
      player_mark = gets.chomp
      break if ['X', 'O'].include? player_mark
    end

    player_mark == 'X' ? computer_mark = 'O' : computer_mark = 'X'

    [player_mark, computer_mark]
  end

  def play
    loop do
      player.move if !game.complete?
      computer.move if !game.complete?
      break if game.won || game.complete?
    end

    puts "\nFINAL BOARD"
    puts "-----------"
    game.render
    winner = game.won
    print "\e[34m"
    if winner 
      puts "#{winner}s won!"
    else 
      puts "Draw!"  
    end
    puts "Thanks for Playing!\e[0m"
  end

end

class Board
  attr_accessor :grid

  def initialize
      @grid = Array.new(3) { Array.new(3, " ") }
  end

  def render
    puts "\n"
    grid.each_with_index do |row, row_idx|
        
        marks = []

        row.each do |mk|
          marks << "\e[32mX\e[0m" if mk == 'X'
          marks << "\e[31mO\e[0m" if mk == 'O'
          marks << ' ' if mk == ' '
        end


        puts " #{marks[0]} | #{marks[1]} | #{marks[2]}"
        puts "------------" unless row_idx == 2
    end
  end

  def empty?(pos)
    row, col = pos
    grid[row][col] == ' ' ? true : false
  end

  def complete?
    grid.each do |row|
      return false if row.include? ' '
    end
    true
  end

  def place_mark(pos, mark)
    row, col = pos
    grid[row][col] = mark
  end

  # IF WINNER FOUND , RETURN X or O.  IF NOT FOUND, retun NIL
  def won
    # check rows
    grid.each do |row|
      if row.uniq.length == 1 && (row.uniq.first == 'X' or row.uniq.first == 'O')
          return row.uniq.first
        end
      end

    # check columns

    0.upto(2) do |col|
      column = []
      column << grid[0][col]
      column << grid[1][col]
      column << grid[2][col]
      if column.uniq.length == 1 && (column.uniq.first == 'X' or column.uniq.first == 'O')
        return column.uniq.first
      end
    end
    # check diagonal 1
    diag = []
    diag << grid[0][0]
    diag << grid[1][1]
    diag << grid[2][2]
    if diag.uniq.length == 1 && (diag.uniq.first == 'X' or diag.uniq.first == 'O')
      return diag.uniq.first
    end

    # check diagonal2
    diag = []
    diag << grid[0][2]
    diag << grid[1][1]
    diag << grid[2][0]
    if diag.uniq.length == 1 && (diag.uniq.first == 'X' or diag.uniq.first == 'O')
      return diag.uniq.first
    end

    nil
  end
end

class Player

  attr_reader :board, :mark

  def initialize(mark, board)
    @mark = mark
    @board = board
  end

  # is # choice okay?
  def valid?(choice)
    if !choice.between?(1,9)
      puts "\e[31mInvalid Selection!\e[0m"
      return false
    end
    pos = choice_to_pos(choice)
    if !board.empty?(pos)
      puts "\e[31mInvalid Selection!\e[0m"
      return false
    end
    true
  end

  # Convert # choice to [row, col]
  def choice_to_pos(choice)
    positions = { 1 => [0,0],
      2 => [0,1],
      3 => [0,2],
      4 => [1,0],
      5 => [1,1],
      6 => [1,2],
      7 => [2,0],
      8 => [2,1],
      9 => [2,2]
    }
    positions[choice]
  end

  # Update board with # choice
  def update_board(pos)
    board.place_mark(pos, mark)
  end

end

class HumanPlayer < Player

  def move
    pos = choice_to_pos(get_choice)
    update_board(pos)
  end

  def prompt_user
    board.render
    print "\n"
    puts " 1 | 2 | 3 "
    puts "------------"
    puts " 4 | 5 | 6 "
    puts "------------"
    puts " 7 | 8 | 9 "
    puts "Where would you like to move?"
    choice = gets.chomp.to_i
  end

  # loops until valid # choice
  def get_choice
    choice = prompt_user
    until valid?(choice)
      choice = prompt_user
    end

    choice
  end

end

class ComputerPlayer < Player

  def move
    pos = get_choice
    update_board(pos)
  end

  # Returns
  def get_choice
    # Check Rows
    board.grid.each_with_index do |row, row_idx|
      if row.count(mark) == 2 && row.count(' ') == 1
        return [row_idx, row.index(' ')]
      end
    end

    #check columns
    0.upto(2) do |col_idx|
      column = []
      column << board.grid[0][col_idx]
      column << board.grid[1][col_idx]
      column << board.grid[2][col_idx]
      if column.count(mark) == 2 && column.count(' ') ==1
        return [column.index(' '), col_idx]
      end
    end

    # check diagonal 1
    diag = []
    diag << board.grid[0][0]
    diag << board.grid[1][1]
    diag << board.grid[2][2]
    if diag.count(mark) == 2 && diag.count(' ') ==1
      return [diag.index(' '), diag.index(' ')]
    end

    # check diagonal 2
    diag = []
    diag << board.grid[0][2]
    diag << board.grid[1][1]
    diag << board.grid[2][0]
    if diag.count(mark) == 2 && diag.count(' ') ==1
      case diag.index(' ')
        when 0
          return [0,2]
        when 1
          return [1,1]
        when 2
          return [2,0]
      end
    end

    get_random_choice
  end

  def get_random_choice
    row, col = nil

    loop do
      row, col = rand(3), rand(3)
      break if board.empty?([row, col])
    end

    [row, col]
  end
end

if __FILE__ == $0

  game = Game.new
  game.play

end
