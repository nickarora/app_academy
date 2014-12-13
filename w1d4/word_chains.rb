require 'set'

class WordChainer

  attr_reader :dictionary

  def initialize(file_name = 'dictionary.txt')
    @dictionary = read_dictionary(file_name).to_set
  end

  def read_dictionary(file_name)
    File.readlines(file_name).map(&:chomp)
  end

  def adjacent_words(word)
    close_words = []
    test_strings = build_test_strings(word)
    
    close_words = test_strings.select do |str|
      @dictionary.include? str
    end

    close_words
  end

  def build_test_strings(word)
    
    test_strings = []
    letter_combos = build_letter_combos(word)

    (0...word.length).each do |index|
      ('a'..'z').each do |letter|
        letter_combos.each do |letter_combo|
          if letter_combo[index] == '!'
            letter_combo[index] = letter
            test_strings << letter_combo.dup
            letter_combo[index] = '!'
          end
        end
      end
    end

    test_strings
  end

  def build_letter_combos(word)
    combos = []
    word.chars.each_index do |i|
      pattern =  word.dup
      pattern[i] = '!'
      combos << pattern
    end

    combos
  end

  def run(source, target)

    @current_words = [source]
    @all_seen_words = { source => nil }
    @source = source

    until @current_words.empty?
      new_current_words = explore_current_words(target)
      @current_words = new_current_words
    end

    p build_path(target)
  end

  def explore_current_words(target)

    new_current_words = []

    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adj_word|
        unless @all_seen_words.keys.include? adj_word
          new_current_words << adj_word 
          @all_seen_words[adj_word] = current_word
          return new_current_words if adj_word == target #break early if we've found our guy
        end
      end
    end

    new_current_words
  end

  def build_path(target)
    path = [target]

    until @all_seen_words[target] == @source
      path << @all_seen_words[target]
      target = @all_seen_words[target]
    end

    path << @all_seen_words[target]

    path.reverse
  end

end

if __FILE__ == $0
  wc = WordChainer.new
  wc.run('path', 'taco')
end
