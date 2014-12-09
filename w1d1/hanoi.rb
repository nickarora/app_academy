def play_hanoi

  loop do
    hanoi
    puts 'Play again? Y or N'
    input = gets.chomp
    break if (input.upcase != 'Y')
  end

  puts "Thanks for Playing!"
end

def output(towers)

  puts "Towers"
  puts "A:" + towers[0].inspect
  puts "B:" + towers[1].inspect
  puts "C:" + towers[2].inspect

end

def hanoi

  tower_choice = {
    A: 0,
    B: 1,
    C: 2
  }

  puts 'How many discs?'
  disc_num = gets.chomp.to_i

  # Initalize arrays
  towers = Array.new(3) { Array.new }
  solution = Array.new(3) { Array.new }

  disc_num.downto(1) do |disc|
    towers[0] << disc
    solution[2] << disc
  end

  until towers == solution

    output(towers)

    puts 'Select a tower to take from [A, B, or C]:'
    start = tower_choice[gets.chomp.to_sym]

    puts 'Select a tower to move to [A, B, or C]:'
    place = tower_choice[gets.chomp.to_sym]

    #Validations

    if [0,1,2].include? start and [0,1,2].include? place and !towers[start].empty? and
        (towers[place].empty? || towers[start].last < towers[place].last)

       #move
       towers[place] << towers[start].pop
    else
      puts "\e[31mInvalid Selection!  Try Again!\e[0m\n"
    end

  end

  #user has won, congratulate them
  output(towers)
  puts "\e[32mCongratulations, you've won!\e[0m"

end

play_hanoi
