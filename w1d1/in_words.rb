class Fixnum
    
    def in_words
        
        str_num = {
            0 => 'zero',
            1 => 'one',
            2 => 'two',
            3 => 'three',
            4 => 'four',
            5 => 'five',
            6 => 'six',
            7 => 'seven',
            8 => 'eight',
            9 => 'nine',
            10 => 'ten',
            11 => 'eleven',
            12 => 'twelve',
            13 => 'thirteen',
            14 => 'fourteen',
            15 => 'fifteen',
            16 => 'sixteen',
            17 => 'seventeen',
            18 => 'eighteen',
            19 => 'nineteen',
            20 => 'twenty',
            30 => 'thirty',
            40 => 'forty',
            50 => 'fifty',
            60 => 'sixty',
            70 => 'seventy',
            80 => 'eighty',
            90 => 'ninety'
        }
        
        result = String.new

        if (0..19).include? self or [10, 20, 30, 40, 50, 60, 70, 80, 90].include? self
            result += str_num[self]
        elsif self < 100 
            right_place = self % 10
            left_place = self - right_place
            result += "#{left_place.in_words}" + ' ' + "#{right_place.in_words}"
        elsif self < 1_000
            right_place = self % 100
            left_place = (self - right_place) / 100
            result += "#{left_place.in_words}" + ' hundred'
            result += " #{right_place.in_words}" if right_place > 0
        elsif self < 1_000_000
            right_place = self % 1_000
            left_place = (self - right_place) / 1_000
            result += "#{left_place.in_words}" + ' thousand'
            result += " #{right_place.in_words}" if right_place > 0
        elsif self < 1_000_000_000
            right_place = self % 1_000_000
            left_place = (self - right_place) / 1_000_000
            result += "#{left_place.in_words}" + ' million'
            result += " #{right_place.in_words}" if right_place > 0
        elsif self < 1_000_000_000_000
            right_place = self % 1_000_000_000
            left_place = (self - right_place) / 1_000_000_000
            result += "#{left_place.in_words}" + ' billion'
            result += " #{right_place.in_words}" if right_place > 0
        elsif self < 1_000_000_000_000_000
            right_place = self % 1_000_000_000_000
            left_place = (self - right_place) / 1_000_000_000_000
            result += "#{left_place.in_words}" + ' trillion'
            result += " #{right_place.in_words}" if right_place > 0
        end
        
        result
    end

end

if __FILE__ == $0

    puts "In Words"
    puts 123423423.in_words

end
