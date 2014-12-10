class NumberGame

  attr_reader :magic_number, :number_of_guesses

  def initialize
    @magic_number = choose_number
    @number_of_guesses = 0
  end

  def run
    guess = get_guess
    while !won?(guess)
      guess = get_guess
    end
  end

  def won?(guess)
    if guess == nil
      false
    elsif guess > magic_number
      puts "high"
      false
    elsif guess < magic_number
      puts "low"
      false
    else
      puts "\e[32mCongrautlations! You got it!\e[0m"
      true
    end
  end

  def choose_number
    rand(100) + 1
  end

  def get_guess
    guess = nil
    while !valid_guess?(guess)
      puts "Pick a number between 1 and 100"
      guess = gets.chomp.to_i
    end
    guess
  end

  def valid_guess?(guess)
    return false if guess == nil
    valid = guess.between?(1,100)
    puts "Invalid Guess" if !valid

    valid
  end

end


if __FILE__ == $0
  game = NumberGame.new
  game.run
end
