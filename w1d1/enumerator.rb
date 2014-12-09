def times_two(arr)
  arr.map {|e| e * 2 }
end

def find_median(arr)
  if (arr.length % 2 == 0)
    mid = arr.length/2
    result = (arr[mid]+arr[mid-1])/2.0
  else
    result = arr[arr.length/2]
  end
end

def concatenate(arr)
  arr.inject(:+)
end

class Array
  def my_each(&block)
    0.upto(self.length - 1) do |idx|
      yield(self[idx])
    end
  end
end