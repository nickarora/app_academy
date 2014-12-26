require_relative 'errors'
require_relative 'card'


class Deck

  attr_reader :cards

  def initialize
    @cards = create_deck
    shuffle
  end

  def create_deck
    card_set = []
    Card.values.each do |val|
      Card.suits.each do |suit|
        card_set << Card.new(val, suit)
      end
    end

    card_set
  end

  def count
    @cards.count
  end

  def shuffle
    @cards.shuffle!

    self
  end

  def draw(n)
    raise CardNumberError unless n.between?(1,5)
    @cards.shift(n)
  end

  def add(card)
    raise NotCardError unless card.is_a? Card
    @cards << card unless self.count == 52

    self
  end

  def deal_hand
    draw(5)
  end

end
