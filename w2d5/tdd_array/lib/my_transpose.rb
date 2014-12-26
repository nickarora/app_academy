def my_transpose(arr)

  result = Array.new(arr.first.length) { Array.new(arr.length) }

  (0...arr.length).each do |row_index|
    (0...arr.first.length).each do |col_index|
      result[col_index][row_index] = arr[row_index][col_index]
    end
  end

  result
end
