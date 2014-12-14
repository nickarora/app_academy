def bubble_sort(arr)
	
	sorted = false
	until sorted
		sorted = true

		(0...(arr.length - 1)).each do |i|
			if arr[i] > arr[i+1] #unsorted
				sorted = false
				arr[i], arr[i+1] = arr[i+1], arr[i]
			end
		end

	end

	arr
end

def quick_sort(arr)
	return arr if arr.length <= 1
	pivot = arr.pop # any number can be the pivot
	left  = arr.select {|n| n < pivot}
	right = arr.select {|n| n > pivot}
	quick_sort(left) + [pivot] + quick_sort(right)
end

def merge_sort(arr)

	#base case
	return arr if arr.length <= 1

	midpoint = arr.length / 2
	left = arr.take(midpoint)
	right = arr.drop(midpoint)

	sorted_left = merge_sort(left)
	sorted_right = merge_sort(right)
	merge(sorted_left, sorted_right)

end

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