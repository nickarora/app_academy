require 'deck'

describe Deck do

  it "creates 52 cards with no duplicates" do
    deck = Deck.new
    expect(deck.count).to eq(52)
    expect(deck.cards.uniq.count).to eq(52)
  end

  it "can shuffle the deck" do
    deck1 = Deck.new
    deck2 = Deck.new
    deck1.shuffle
    expect(deck1.cards).not_to eq(deck2.cards)
  end

  it "should be able to draw five cards" do
    deck = Deck.new
    deck.shuffle
    expect(deck.draw(5)).to be_a(Array).and include(Card)
    expect(deck.draw(5).length).to eq(5)
  end

  it "should not be able to draw more than five cards" do
    deck = Deck.new
    deck.shuffle
    expect do
      deck.draw(6)
    end.to raise_error(CardNumberError)
  end

  it "should remove drawn cards from the deck" do
    deck = Deck.new
    deck.shuffle
    deck.draw(5)
    expect(deck.count).to eq(47)
  end

  it "can add cards back to the deck" do
    deck = Deck.new
    taken_card = deck.draw(1)
    deck.add(taken_card.first)
    expect(deck.count).to eq(52)
  end


end
