class Array

  def my_uniq
    seen = []
    (0...self.length).each do |el|
      seen << self[el] unless seen.include? self[el]
    end

    seen
  end

  def two_sum
    zeroes = []
    (0...self.length).each do |first|
      (first + 1...self.length).each do |last|
        zeroes << [first, last] if self[first] + self[last] == 0
      end
    end
    zeroes
  end

end
