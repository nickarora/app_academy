def rps(player_choice)

  computer_choice = ["Rock", "Paper", "Scissors"].sample

  if player_choice == computer_choice
    puts "#{computer_choice}, Draw!"
  elsif player_choice == "Rock"
    if computer_choice == "Paper"
      puts "#{computer_choice}, Lose!"
    else
      puts "#{computer_choice}, Win!"
    end
  elsif player_choice == "Paper"
    if computer_choice == "Scissors"
      puts "#{computer_choice}, Lose!"
    else
      puts "#{computer_choice}, Win!"
    end
  else
    if computer_choice == "Rock"
      puts "#{computer_choice}, Lose!"
    else
      puts "#{computer_choice}, Win!"
    end
  end

end

def diff?(remixed, drinks)
  0.upto(remixed.length - 1) do |i|
    return false if drinks.include? remixed[i]
  end
  true
end

def remix(drinks)
  remixed = Array.new

  loop do
    transposed_drinks = drinks.transpose
    transposed_drinks.map! do |row|
      row.shuffle
    end
    remixed = transposed_drinks.transpose
    break if diff?(remixed, drinks)
  end

  remixed
end


if __FILE__ == $0
  # rps("Rock")
  # rps("Scissors")
  # rps("Scissors")
p  remix([
    ["rum", "coke"],
    ["gin", "tonic"],
    ["scotch", "soda"]
    ])
end
