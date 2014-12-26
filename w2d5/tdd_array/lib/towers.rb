class InvalidMoveError < ArgumentError
  def message
    "Invalid Move!"
  end
end

class Towers

  attr_reader :pegs

  def initialize
    set_up_pegs
  end

  def set_up_pegs
    @pegs =  [ [3,2,1], [], [] ]
  end

  def move(start_peg, end_peg)
    raise InvalidMoveError unless @pegs[end_peg].empty? ||
                                  @pegs[end_peg].last > @pegs[start_peg].last
    @pegs[end_peg] << @pegs[start_peg].pop
     if game_over?
       won_game
     end
  end

  def game_over?
    return true if @pegs == [[], [], [3,2,1]]
    false
  end

  def won_game
    puts "Good Job!"
  end

end
