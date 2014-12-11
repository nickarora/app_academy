class Hangman

	MAX_GUESSES = 10

	def initialize(guesser, checker)
		@guesser, @checker = guesser, checker
		@remaining_guesses = MAX_GUESSES
	end

	def play
		secret_length = @checker.pick_secret_word
		@guesser.register_secret_length(secret_length)

		@current_board = Array.new(secret_length)

		while @remaining_guesses > 0
			draw
			take_turn

			if won?
				@guesser.output(@current_board)
				puts "\e[31mGuesser wins!\e[0m"
				return
			end
		end

		draw
		puts "\e[31mGuesser Loses!\e[0m"
		@checker.reveal_word

	end

	def take_turn
		guess = @guesser.guess(@current_board, @remaining_guesses)
		
		# found_spots returns an array of indexes where the guess
		# is located!
		found_spots = @checker.check_guess(guess)
		update_board(guess, found_spots)

		@remaining_guesses -= 1 if found_spots.empty?

		@guesser.handle_response(guess, found_spots)
	end

	def update_board(guess, found_spots)
		found_spots.each do |idx|
			@current_board[idx] = guess
		end
	end

	def won?
		@current_board.all?
	end

	def draw
		
		body = {
			10 => '',
			9 => 'O',
			8 => 'O-',
			7 => 'O--',
			6 => 'O-|',
			5 => 'O-|-',
			4 => 'O-|--',
			3 => "O-|--<",
			2 => 'O-|--< |',
			1 => "       |\nO-|--< |",
			0 => "|=======|\nO-|--<  |"
		}

		puts "\n"
		puts "\e[31m" + body[@remaining_guesses] + "\e[0m"
		puts "\n"
	end

end

class HumanPlayer
	
	def pick_secret_word
		puts "Think of a secret_word. how long is it?"
		begin
			input = Integer(gets.chomp)
		rescue ArgumentError
			puts "Enter a valid length!"
			retry
		end

		input
	end	

	def register_secret_length(length)
		puts "Secret is #{length} letters long!"
	end

	def guess(board, remaining_guesses)
		puts "#{remaining_guesses} Guesses Remaining!"
		output(board)
		input = nil
		until ('A'..'Z').include? input
			puts "Choose a letter and hit enter!"
			input = gets.chomp.upcase
		end
		input
	end

	def output(board)
		puts "\n"
		board.each do |item|
			if item 
				print "\e[32m#{item} \e[0m"
			else
				print "_ "
			end
		end
		puts "\n"
	end

	def check_guess(guess)
		puts "Your opponent guessed \e[32m#{guess.upcase}\e[0m!"
		puts "What positions did that occur at?"
		puts "(Seperate each number with a space!)"

		positions = gets.chomp.split(" ").map(&:to_i)
	end

	def handle_response(guess, found_spots)
		puts "Found #{guess} at the following positions #{found_spots}"
	end

	def reveal_word
		puts "Go ahead and scream your name at your computer screen!"
	end

end

class ComputerPlayer

	def initialize(dict_file_name)
		@dictionary = read_dictionary(dict_file_name)
	end

	def read_dictionary(dict_file_name)
		File.readlines(dict_file_name).map(&:chomp)
	end

	def pick_secret_word
		@secret_word = @dictionary.sample.upcase
		puts "SECRET WORD: #{@secret_word}"
		@secret_word.length # return this value
	end

	def register_secret_length(length)
		@candidate_words = @dictionary.dup
		@candidate_words.select! { |word| word.length == length }
	end

	def guess(board, remaining_guesses)

		output(board)

		# Returns a hash of letters that appear
		# in our candidate words in BLANK locations
		# on our board AND their associated frequncy
		frequencies = get_frequencies(board)

		# reverse sorts the frequnecies.  the final entry is now
		# the most frequently appearing in the blank spots.
		most_frequent_letters = frequencies.sort_by { |letter, count| count }
		letter, count = most_frequent_letters.last

		puts "Computer chooses: #{letter}"
		letter
	end

	def output(board)
		puts "\n"
		board.each do |item|
			if item 
				print "\e[32m#{item} \e[0m"
			else
				print "_ "
			end
		end
		puts "\n"
		board.each_index do |idx|
			print "#{idx} "
		end
		puts "\n"
	end

	def get_frequencies(board)
		freq = Hash.new(0)
		@candidate_words.each do |word|
			board.each_with_index do |letter, pos|
				freq[word[pos]] += 1 if letter.nil?
			end
		end

		freq
	end

	def check_guess(guess)
		response = []
		@secret_word.chars.each_with_index do |letter, index|
			response << index if letter == guess.upcase
		end

		response
	end

	def handle_response(guess, found_spots)
		@candidate_words.reject! do |word|

			decision = false

			word.chars.each_with_index do |letter, index|
				if (letter == guess) && (!found_spots.include? index)
					decision = true
				elsif (letter != guess) && (found_spots.include? index)
					decision = true
				end
			end

			decision
		end
	end

	def reveal_word
		puts "The word was: #{@secret_word}"
	end

end

class Game

	def initialize
		@human = HumanPlayer.new
		@computer = ComputerPlayer.new("dictionary.txt")
	end

	def play
		human_guesses = prompt_user

		if human_guesses
			hangman = Hangman.new(@human, @computer)
		else
			hangman = Hangman.new(@computer, @human)
		end

		hangman.play
	end

	def prompt_user
		input = nil
		until valid_input?(input)
			puts "Who is the guesser? (human or computer)"
			input = gets.chomp(input).downcase
		end
		
		if input == 'human' 
			return true
		else
			return false
		end
	end

	def valid_input?(input)
		return nil if input.nil?
		return false if ['human', 'computer'].include? input
		true
	end
end

if __FILE__ == $PROGRAM_NAME

	game = Game.new
	game.play

end

