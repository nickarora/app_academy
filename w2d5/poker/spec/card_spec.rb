require 'colorize'
require 'card'

describe Card do

  it "creates a card with proper suits and values" do
    card = Card.new(:king, :hearts)
    expect(card).to be_a(Card)
    expect(card.suit).to eq(:hearts)
    expect(card.value).to eq(:king)
  end

  it "will raise an error if creating card using an unknown suit" do
    expect do
      Card.new(:king, :airplane)
    end.to raise_error(InvalidCardError)
  end

  it "will raise an error if creating a card using an unknown value" do
    expect do
      Card.new(:taco, :hearts)
    end.to raise_error(InvalidCardError)
  end
  it "will print out the suit and value" do
    card = Card.new(:king, :hearts)
    expect(card.to_s).to eq("K♥".green)
  end
  it "will correctly compare cards of different values" do
    card1 = Card.new(:king, :spades)
    card2 = Card.new(:seven, :spades)
    expect(card1 > card2).to eq(true)
    expect(card1 < card2).to eq(false)
  end
  it "will correctly compare cards of the same value and different suits" do
    card1 = Card.new(:king, :spades)
    card2 = Card.new(:king, :hearts)
    expect(card1 > card2).to eq(true)
    expect(card1 < card2).to eq(false)
  end
end
