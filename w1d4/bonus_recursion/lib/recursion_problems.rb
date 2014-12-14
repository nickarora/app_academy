#Problem 1: You have array of integers. Write a recursive solution to find
#the sum of the integers.

def sum_recur(array)
	return 0 if array.empty?
	return array.first if array.count == 1
	array.last + sum_recur( array.take(array.count - 1))
end


#Problem 2: You have array of integers. Write a recursive solution to
#determine whether or not the array contains a specific value.

def includes?(array, target)
	return false if array.empty?
	return true if array.first == target 
	includes?(array.drop(1), target)
end


#Problem 3: You have an unsorted array of integers. Write a recursive
#solution to count the number of occurrences of a specific value.

def num_occur(array, target)
  return 0 if array.empty?
  num_occur(array.drop(1), target) + (array.first == target ? 1 : 0)
end


#Problem 4: You have array of integers. Write a recursive solution to
#determine whether or not two adjacent elements of the array add to 12.

def add_to_twelve?(array)
	return false if array.count < 2
 	return true if array.take(2).reduce(:+) == 12
 	add_to_twelve?(array.drop(1))
end


#Problem 5: You have array of integers. Write a recursive solution to
#determine if the array is sorted.

def sorted?(array)
	return true if array.empty? || array.count == 1
	return false if array[0] > array[1] 
	sorted?(array.drop(1))
end


#Problem 6: Write the code to give the value of a number after it is
#reversed. Must use recursion. (Don't use any #reverse methods!)

def reverse(number) #257
  return number if number < 10
  place = 10**(number.to_s.length - 1)
  left = number / place
  right = number % place
  (reverse(right) * 10) + left
end


