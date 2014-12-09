class Array

  def my_uniq
    uniq_array = []
    (0..self.length-1).each do |idx|
      uniq_array << self[idx] unless uniq_array.include? self[idx]
    end

    uniq_array
  end

  def two_sum
    results = []
    (0..self.length-1).each do |i|
      (i..self.length-1).each do |k|
        results << [i,k] if i != k && (self[i] + self[k] == 0)
      end
    end

    results
  end

end

if __FILE__ == $0

  puts "My_uniq:"
  puts "#{[1, 2, 1, 3, 3].my_uniq}"
  puts "Two_sum:"
  puts "#{[-1, 0, 2, -2, 1].two_sum}"

end
