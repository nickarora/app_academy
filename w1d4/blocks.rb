class Array

  # returns the array without mutating it, emulates Array#each
  def my_each
    0.upto(self.length - 1) do |el|
      yield(self[el])
    end

    self
  end

  # emulates Array#map
  def my_map
    result = []
    self.my_each do |el|
      result << yield(el)
    end

    result
  end

  # emulates Array#select
  def my_select
    result = []
    self.my_each do |el|
      result << el if yield(el)
    end

  result
  end

  # emulates Enumerable#inject
  def my_inject
    sum = self.first
    self.my_each do |el|
      sum = yield(sum, el)
    end

    sum
  end

  # my_sort emulates sort, mutates
  def my_sort!(&block)
    sorted = false
    until sorted
      sorted = true
      0.upto(self.length - 2) do |el|
        if yield(self[el], self[el + 1]) == 1
          sorted = false
          self[el], self[el + 1] = self[el + 1], self[el]
        end
      end
    end

    self
  end

  # non-mutating sort
  def my_sort(&block)
    new_arr = self.dup
    new_arr.my_sort!(&block)
  end

end

# evaluate a block with an unknown number of arguments
# pass function a block
def eval_block(*arg, &block)
  block_given? ? yield(arg) : "NO BLOCK GIVEN"
end
