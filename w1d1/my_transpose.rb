def my_transpose(arr)

  rows = arr.count
  cols = arr[0].count
  results = Array.new(cols) { Array.new(rows) }

  arr.each_with_index do |row, row_idx|
    row.each_with_index do |element, col_idx|
      results[col_idx][row_idx] = element
    end
  end

  results
end

if __FILE__ == $0

  test = [[0, 1, 2],
          [3, 4, 5],
          [6, 7, 8]]

  puts "My Transpose:"
  my_transpose(test).each do |line|
    puts line.inspect
  end

end
