 class RPNCalculator

  attr_accessor :stack

  def initialize
    @stack = []
  end

  def run
    input = get_input
    tok = tokens(input)
    puts "SOLUTION: #{evaluate(tok)}"
  end

  def push(n)
    stack << n
  end

  def plus
    stack << stack.pop + stack.pop
  end

  def minus
    first = stack.pop
    second = stack.pop
    stack << second - first
  end

  def times
    stack << stack.pop * stack.pop
  end

  def divide
    first = stack.pop
    second = stack.pop
    stack << second / first
  end

  def value
    stack.last
  end

  def tokens(input)
    functions = [ "+", "-", "*", "/" ]
    tokens = input.map do |el|
      functions.include?(el) ? el.to_sym : el.to_i
    end
    tokens
  end

  def evaluate(tokens)
    tokens.each do |x|
      case x
        when :+
          plus
        when :-
          minus
        when :*
          times
        when :/
          divide
        else
          push(x)
      end
    end
    value
  end

  def get_input

    input = []

    puts "Start Entering your Numbers and Symbols"
    puts "Use numbers, +, -, *, and /"
    puts "Press enter when done."

    loop do
      next_command = gets.chomp
      if next_command == ""
        break
      else
        input << next_command
      end
    end

    input
  end

end

if __FILE__ == $0
  calc = RPNCalculator.new
  calc.run
end
