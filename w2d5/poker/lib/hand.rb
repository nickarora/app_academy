require_relative 'errors'
require_relative 'card'
require_relative 'deck'

class Hand

  include Comparable

  attr_reader :cards

  def initialize(cards)
    raise CardNumberError if cards.count != 5
    @cards = cards.sort
  end

  def inspect
    @cards.inspect
  end

  def [](pos)
    @cards[pos]
  end

  def discard(del_cards)
    del_cards.each do |c|
      @cards.delete(c)
    end

    self
  end

  def trade_cards(old_cards, new_cards)
    how_many = old_cards.length
    raise "wrong number to trade" if how_many != new_cards.length
    discard(old_cards)
    add(new_cards)

    how_many
  end

  def add(cards_arr)
    raise CardNumberError if (@cards.count + cards_arr.count) > 5
    @cards += cards_arr
    @cards.sort!
  end

  def <=>(other_hand)
    score_hand <=> other_hand.score_hand
  end

  def score_hand
    score = 0

    if has_straightflush?
      score = (Card.num_values[suits.first] * 10)
      score += (low_straight? ? numeric_values[-2] : numeric_values.max) + 1000
    elsif has_four?
      repeated = get_repeats.first
      score = (repeated * 4) + 800
    elsif has_fullhouse?
      triple, double = split_fullhouse
      score = (triple * 10) + (double) + 600
    elsif has_flush?
      score = (Card.num_values[suits.first] * 10) + 500
    elsif has_straight?
      score = (low_straight? ? numeric_values[-2] : numeric_values.max) + 400
    elsif has_three?
      threesome = get_repeats.first
      score = (threesome * 3) + 300
    elsif two_pair?
      pairs = get_repeats
      score = (pairs[0] * 2) + (pairs[1] * 2) + 200
    elsif one_pair?
      pair = get_repeats.first
      score = (pair * 2) + 100
    else #high_card
      score = numeric_values.max
    end

    score
  end

  def low_straight?
    numeric_values.include?(2) && numeric_values.include?(14)
  end

  def sum_card_values
    numeric_values.inject(:+)
  end

  def get_repeats
    pairs = count_values.select {|k,v| v > 1}.keys
  end

  def count_values
    counts = Hash.new(0)
    numeric_values.each { |val| counts[val] += 1 }

    counts
  end

  def split_fullhouse
    triple = count_values.select { |k, v| v == 3 }.keys
    double = count_values.select { |k, v| v == 2 }.keys
    (triple + double).flatten
  end

  def values
    cards.map { |card| card.value }
  end

  def numeric_values
    values.map { |x| Card.num_values[x] }
  end

  def suits
    cards.map { |card| card.suit }
  end

  def two_pair?
    count = 0
    values.uniq.each { |card| count+= 1 if values.count(card) == 2 }
    count == 2 ? true : false
  end

  def one_pair?
    count = 0
    values.uniq.each { |card| count += 1 if values.count(card) == 2 }
    count == 1 ? true : false
  end

  def has_three?
    values.uniq.each { |card| return true if values.count(card) == 3 }
    false
  end

  def has_four?
    values.uniq.each { |card| return true if values.count(card) == 4 }
    false
  end

  def consecutive?(arr)
    (0...arr.length - 1).each do |i|
      return false unless arr[i+1] - arr[i] == 1
    end

    true
  end

  def has_straight?
    nums = numeric_values
    alt_nums = nums.map { |n| n == 14 ? 1 : n }.sort
    return false unless consecutive?(alt_nums) || consecutive?(nums)

    true
  end

  def has_flush?
    return true if suits.uniq.count == 1
    false
  end

  def has_fullhouse?
    one_pair? && has_three?
  end

  def has_straightflush?
    has_straight? && has_flush?
  end

end
