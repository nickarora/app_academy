def factors(num)
  results = []

  1.upto(num) do |n|
    results << n if num % n == 0
  end

  p results
end

def bubble_sort(arr)
  bubble = arr
  sorted = false
  while !sorted
    sorted = true
    0.upto(bubble.length-2) do |x|
      if bubble[x] > bubble[x+1]
        bubble[x], bubble[x+1] = bubble[x+1], bubble[x]
        sorted = false
      end
    end
  end
  bubble
end

def substrings(str)

  results = []
  max = str.length - 1

  (0..max).each do |first|
    (first..max).each do |second|
      results << str[first..second]
    end
  end

  only_english_words(results)
end

def only_english_words(substr_arr)
  words = File.readlines("dictionary.txt").map(&:chomp)
  substr_arr.reject! { |x| !words.include? x }
  substr_arr
end



if __FILE__ == $0

  #bubble_sort([2,1,4,3])
  p substrings("cat")

end
