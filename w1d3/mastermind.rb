class Code

  LETTERS = ["R", "G", "B", "Y", "O", "P"]
  attr_accessor :code

  def initialize(code_arr)
    @code = code_arr
  end

  def self.random
    arr = []
    4.times { arr << LETTERS.sample }
    self.new(arr)
  end

  # validate user input and store it using .new / returns code object
  def self.parse(input)
    input.upcase!
    return nil unless self.is_valid?(input)
    self.new(input.chars)
  end

  def self.is_valid?(input)
    return false unless input.length == 4
    input.each_char do |char|
      return false unless LETTERS.include?(char)
    end

    true
  end

end

class Game

  MAX_TURNS = 10

  attr_accessor :turns
  attr_reader :correct_code

  def initialize
    @correct_code = Code.random
    @turns = 1
  end

  def play
    puts "Welcome to the Mastermind game.\n"
    until @turns == MAX_TURNS
      guess = get_input
      exact, near = feedback(guess)
      win_game if won?(guess)
      puts "#{exact} exact matches, #{near} near matches\n"
      puts "Turns left: #{MAX_TURNS - @turns}"
      @turns += 1
    end
    lost_game
  end

  def win_game
    puts "You've won the game!\n"
    exit(0)
  end

  def lost_game
    puts "You've lost the game!\n"
    puts "The Correct Code: #{correct_code.code.join}"
  end

  def get_input
    input = false

    until input
      puts "Choose Four Colors (R, G, B, Y, O, P):"
      input = Code.parse(gets.chomp)
    end

    input #return Code object
  end

  def color_hash
    color_count = Hash.new(0)
    correct_code.code.each do |code|
      color_count[code] += 1
    end
    color_count
  end

  def feedback(guess)

    exact_matches = 0
    near_matches = 0

    color_count = color_hash

    guess.code.each_with_index do |color, pos|
      if color == correct_code.code[pos]
        exact_matches += 1
        color_count[color] -= 1
      elsif correct_code.code.include?(color) && color_count[color] > 0
        near_matches += 1
        color_count[color] -= 1
      end
    end

    [exact_matches, near_matches]
  end

  def won?(guess)
    guess.code == @correct_code.code
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
