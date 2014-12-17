class QueenSolver

	def initialize(n = 8)
		@n = n
		@max_index = n - 1
	end

	def run
		puts "N_Queens - Solving for #{@n} Queens:"
		@solutions = solve
		puts "Found #{@solutions.count} Solutions!"
		display? unless @solutions.empty?
	end

	private

		def display?
			loop do
				case prompt_user
					when 'N', 'Q'
						exit
					when 'Y'
						render(@solutions.sample)
				end
			end	
		end

		def render(solution)
			board = Array.new(@n) { Array.new(@n) }

			positions = []

			solution.each_with_index do |row, col|
				board[row][col] = '♔'
			end

			draw(board)
		end

		def draw(board)

			board.each do |row|
				row.each do |el|
					if el.nil? 
						print "_ " 
					else 
						print "\e[32m" + el + "\e[0m "
					end
				end
				puts "\n"
			end

			nil
		end

		def prompt_user
			input = nil
			until ['Y', 'N', 'Q'].include? input
				puts "Would you like to display a random solution? (Y, N, or Q)"
				input = STDIN.gets.chomp.upcase
			end

			input
		end

		def solve
			@boards = (0..(@n-1)).to_a.permutation.to_a
			@boards.reject! do |board|
				queens_on_same_diagonal?(board)
			end
			@boards
		end

		def queens_on_same_diagonal?(board)
			board.each_with_index do |row, col|
				0.upto(@max_index) do |check|
					col_dist = (col - check).abs
					if col_dist > 0
						if (board[check] == row + col_dist) ||
							 (board[check] == row - col_dist)
							 return true
						end
					end
				end
			end

			return false
		end
	
end

if __FILE__ == $0
	if ARGV.empty?
		queens = 8
	else
		queens = ARGV.first.to_i
	end

	QueenSolver.new(queens).run
end