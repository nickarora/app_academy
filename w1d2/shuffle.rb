class ShuffleLines
  attr_reader :filename

  def initialize
    @filename = get_filename
  end

  def get_filename
    puts "What file would you like to shuffle?"
    gets.chomp
  end

  def shuffle
    lines = File.readlines(filename)
    lines.shuffle!
    new_filename = get_new_filename
    File.open(new_filename, "w") do |f|
      lines.each do |line|
        f.puts line
      end
    end

  end

  def get_new_filename
    original = filename.split(".")[0]
    original += "-shuffled.txt"
  end
end

if __FILE__ == $0
  book = ShuffleLines.new
  book.shuffle
end
