# Range: uses recursion to return the start and end and all numbers between
# takes two arguments min and max
def range(min, max)
  return [] if min > max
  return [min] if min == max
  [min] + range(min + 1, max)
end

# Recusive method which sums an array
def recursive_sum(array)
  return 0 if array.nil?
  return array.first if array.length == 1
  array.first + recursive_sum(array[1..-1])
end

# Iterative method which sums an array
def iter_sum(array)
  array.inject(:+)
end

# Exponentiate 1
def exp1(base, power)
  return 1 if base == 0
  return base if power == 1
  base * exp1(base, power - 1)
end

# Exponentiate 2
def exp2(base, power)
  return 1 if base == 0
  return base if power == 1
  if power.even?
    exp2(base, power / 2) * exp2(base, power / 2)
  else
    base * (exp2(base, (power - 1) / 2) * exp2(base, (power - 1) / 2))
  end
end

# Duplicates the entirety of nested arrays
def deep_dup(array)

  result = []
  # return array.dup unless array.first.is_a? Array

  array.each do |el|
    if el.is_a? Array
      result << deep_dup(el)
    else
      result <<  el
    end
  end

  result
end

# Recursive fib sequence
def fib(n)
  return [] if n == 0
  return [0] if n == 1
  return [0, 1] if n == 2
  arr = fib(n - 1)
  arr + [arr[-1] + arr[-2]]
end

# Binary Search
# nil if not found
# location of the found object if found!
def bsearch(array, target)

  return nil if array.nil?

  middle_idx = (array.length / 2)
  left = array[0..(middle_idx - 1)]
  right = array[(middle_idx + 1)..-1]

  return middle_idx if target == array[middle_idx]
  if target < array[middle_idx]
    bsearch(left, target) unless target < array.first
  else
    1 + middle_idx + bsearch(right, target) unless target > array.last
  end
end

# Merge: Merge two sorted halves!
def merge(arr1, arr2)
  sorted_arr = []
  until arr1.empty? || arr2.empty?
    if arr1.first < arr2.first
      sorted_arr << arr1.shift
    else
      sorted_arr << arr2.shift
    end
  end

  sorted_arr + arr1 + arr2
end

# Merge Sort
def merge_sort(arr)

  return arr if arr.length == 1
  pivot = (arr.length / 2) - 1

  left = arr[0..pivot]
  right = arr[(pivot + 1)..-1]

  sorted_left = merge_sort(left)
  sorted_right = merge_sort(right)
  merge(sorted_left, sorted_right)
end

# Subsets: return all subsets of an array
def subsets(array)
  # base case
  result = []

  return [array] if array.length == 1

  array.each_index do |i|
    alt_array = array.dup
    alt_array.delete_at(i)
    result += subsets(alt_array)
  end

  (result + [array]).uniq.sort
end

def make_change(target, coins_arr)
  result = []
  return nil if target < 0
  return result if target == 0

  best_combo = nil
  coins_arr.each do |coin|

    next if coin > target

    coins = make_change(target - coin, coins_arr)
    next if coins.nil?

    result = [coin] + coins

    if best_combo.nil? || result.length < best_combo.length
      best_combo = result
    end

  end

  best_combo
end
