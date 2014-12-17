require 'yaml'
require 'colorize'
require 'io/console'

class Board

  attr_accessor :play_field, :bombs

  def initialize
    @bombs = []
    @play_field = set_up_play_field
  end

  def set_up_play_field

    @bombs = generate_bombs_coords

    field = Array.new(9) { Array.new(9) }
    (0...9).each do |row|
      (0...9).each do |col|
        field[row][col] = Tile.new( self, [row, col] )
        if @bombs.include?([row,col])
          field[row][col].bombed = true
        end
      end
    end

    field
  end

  def generate_bombs_coords
    bombs = []
    until bombs.count == 10
      row = rand(9)
      col = rand(9)
      bombs << [row,col] unless bombs.include?([row,col])
    end

    bombs
  end

  def reveal(pos)

    row, col = pos
    start_tile = @play_field[row][col]
    start_tile.reveal

    tile_queue = start_tile.neighbors
    visited_pos = []


    until tile_queue.empty?
      current_pos = tile_queue.shift
      visited_pos << current_pos
      row, col = current_pos
      current_tile = @play_field[row][col]
      bomb_count = current_tile.neighbor_bomb_count
      if bomb_count == 0
        current_tile.neighbors.each do |neighbor|
          tile_queue << neighbor unless visited_pos.include?(neighbor)
        end
      end

      current_tile.reveal unless current_tile.bombed
    end

    nil
  end

  # Returns an array of not revealed
  def get_hidden
    hidden_tiles = []

    (0...9).each do |row|
      (0...9).each do |col|
        hidden_tiles << [row,col] unless @play_field[row][col].revealed
      end
    end

    hidden_tiles
  end

  def render(cursor = nil)
    curs_row, curs_col = cursor if cursor
    puts "MINE SWEEPER!"
    print "  0  1  2  3  4  5  6  7  8\n"
    @play_field.each_with_index do |row, row_index|
      print "#{row_index} "
      row.each_with_index do |item, col_index|
        if curs_row == row_index && curs_col == col_index
          print "#{item}".on_red + "  "
        else
          print "#{item}  "
        end
      end
      puts "\n\n"
    end
    puts "\n"
  end

end

class Tile

  MOVEMENTS = [ [-1, 0],
                [ 1, 0],
                [ 0, -1],
                [ 0,  1],
                [-1,-1],
                [-1, 1],
                [ 1, -1],
                [ 1, 1]
              ]

  attr_accessor :bombed, :pos, :flagged, :revealed

  def initialize(board, pos)
    @board = board
    @pos = pos
    @revealed = false
    @bombed = false
    @flagged = false
  end

  def to_s
    unless @revealed
      return "\u2691".green if @flagged
      return " ".on_white
    end

    return "X".red if @bombed
    count = neighbor_bomb_count
    return count.to_s if count > 0
    "_"
  end

  def reveal
    @revealed = true unless @flagged
  end

  def neighbors
    coords = []

    current_row, current_col = @pos

    MOVEMENTS.each do |move|
      v_move, h_move = move
      new_move = [current_row + v_move, current_col + h_move]
      coords <<  new_move if move_valid?(new_move)
    end

    coords
  end

  def move_valid?(pos)
    row, col = pos
    return false if row < 0 || col < 0 || row > 8 || col > 8

    true
  end

  def neighbor_bomb_count
    count = 0
    neighbors.each do |neighbor|
      row, col = neighbor
      count += 1 if @board.play_field[row][col].bombed
    end

    count
  end


end

class Game

  attr_accessor :board

  def initialize
    @board = get_board
    @cursor = [0,0]
  end


  def get_board
    game = nil
    until ["N","L"].include?(game)
      puts "Do you want to start new game(n) or load saved game(l)?"
      game = gets.chomp.upcase
    end

    return Board.new if game == "N"

    load_game
  end

  def load_game
    filename = get_file
    YAML.load_file(filename)
  end

  def run
    until game_over?
      system("clear")
      @board.render(@cursor)

      input = STDIN.getch
      case input
        when "w"
          @cursor[0] -= 1 if @cursor[0] > 0
        when "s"
          @cursor[0] += 1 if @cursor[0] < 8
        when "d"
          @cursor[1] += 1 if @cursor[1] < 8
        when "a"
          @cursor[1] -= 1 if @cursor[1] > 0
        when "f"
          row, col = @cursor
          selected_tile = @board.play_field[row][col]
          selected_tile.flagged ^= true
        when "q","x"
          save = get_save_input
          case save
            when "S"
              save_handler
            when "Q"
              exit
            end
        when "r"
          row, col = @cursor
          selected_tile = @board.play_field[row][col]
          if selected_tile.bombed
            game_lost
          else
            unless selected_tile.flagged
              @board.reveal([row, col])
            end
          end
      end

    end

    puts "GOOD JOB YOU WON."
  end

  def get_save_input

    save = nil
    until ["C","S","Q"].include?(save)
      puts "Do you want to save(s) or continue(c) or quit(q)?"
      save = gets.chomp.upcase
    end

    save
  end

  def save_handler
    filename = get_file

    File.open(filename, "w") do |f|
      f.puts @board.to_yaml
    end

    puts "File saved to #{filename}"
    exit
  end

  def get_file
    puts "Enter file name"
    file = gets.chomp

    "#{file}.yml"
  end

  def game_lost
    @board.bombs.each do |bomb|
      row, col = bomb
      @board.play_field[row][col].revealed = true
    end

    system("clear")
    @board.render
    puts "You Found a Bomb!"
    puts "YOU LOSE."
    exit
  end


  def action_valid?(action)
    return false if action == nil
    return false unless ['R', 'F'].include? action

    true
  end

  def coords_valid?(row, col)
    return false if row == nil or col == nil
    return false if row.class != Fixnum || col.class != Fixnum

    true
  end


  def game_over?
    hidden_tiles = @board.get_hidden

    hidden_tiles.each do |tile|
      row, col = tile
      return false unless @board.play_field[row][col].bombed
    end

    true
  end


end


game = Game.new.run
