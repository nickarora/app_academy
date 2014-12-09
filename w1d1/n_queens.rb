class QueenSolver

	def initialize(n = 8)
		@n = n
		@max_index = n - 1
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
					if (board[check] == row + col_dist) or
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


	queens = ARGV.first.to_i
	queens = 8 if queens <= 0 
	puts "N_Queens - Solving for #{queens} Queens:"
	problem = QueenSolver.new(queens)
	puts "Found #{problem.solve.count} Solutions!"
	
end