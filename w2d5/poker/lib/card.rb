require 'colorize'
require_relative 'errors'

class Card

  include Comparable

  SUITS = { :spades => '♠',
            :hearts => '♥',
            :diamonds => '♦',
            :clubs => '♣'
          }

  VALUES = {:two   => "2",
            :three => "3",
            :four  => "4",
            :five  => "5",
            :six   => "6",
            :seven => "7",
            :eight => "8",
            :nine  => "9",
            :ten   => "10",
            :jack  => "J",
            :queen => "Q",
            :king  => "K",
            :ace   => "A"
          }

  NUM_VALUES = {:two   => 2,
                :three => 3,
                :four  => 4,
                :five  => 5,
                :six   => 6,
                :seven => 7,
                :eight => 8,
                :nine  => 9,
                :ten   => 10,
                :jack  => 11,
                :queen => 12,
                :king  => 13,
                :ace   => 14,
                :spades => 0.4,
                :hearts => 0.3,
                :diamonds => 0.2,
                :clubs => 0.1
                }

  attr_reader :value, :suit

  def initialize(value, suit)
    raise InvalidCardError unless SUITS.include?(suit) && VALUES.include?(value)
    @value, @suit = value, suit
  end

  def inspect
    self.to_s
  end

  def self.suits
    SUITS.keys
  end

  def self.values
    VALUES.keys
  end

  def self.num_values
    NUM_VALUES
  end

  def to_s
    "#{VALUES[@value]}#{SUITS[@suit]}".green
  end

  def to_i(c)
    NUM_VALUES[c.value] + NUM_VALUES[c.suit]
  end

  def <=>(other_card)
    to_i(self) <=> to_i(other_card)
  end

end
