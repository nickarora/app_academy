def to_s_method(num, base)

  hex_dictionary = {
    0 => '0',
    1 => '1',
    2 => '2',
    3 => '3',
    4 => '4',
    5 => '5',
    6 => '6',
    7 => '7',
    8 => '8',
    9 => '9',
    10 => 'A',
    11 => 'B',
    12 => 'C',
    13 => 'D',
    14 => 'E',
    15 => 'F'
  }


  results = []

  while (num > 0)
    results << num % base
    num = num / base
  end

  results.reverse.map {|n| hex_dictionary[n] }.join
end

def caesar(str, num)
  arr = str.split("")
  arr.map! do |char|
    shifted_char = char.ord+num
    if ( shifted_char > "z".ord)
      shifted_char -= 26
    end

    shifted_char.chr
  end

  arr.join
end

if __FILE__ == $0

  puts "To_s Method:"
  puts to_s_method(234, 16)
  puts "\nCaesar Cipher:"
  puts caesar("abcz", 4)

end
