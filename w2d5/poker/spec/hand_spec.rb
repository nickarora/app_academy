require 'hand'

describe Hand do
  it "has five cards" do
    cards =
    [
      Card.new(:two, :clubs),
      Card.new(:four, :spades),
      Card.new(:six, :hearts),
      Card.new(:eight, :spades),
      Card.new(:ten, :clubs)
    ]

    hand = Hand.new(cards)
    expect(hand.cards.count).to eq(5)
  end

  it "decides that a high card beats the lower card" do
    cards1 =
      [
        Card.new(:two, :clubs),
        Card.new(:four, :spades),
        Card.new(:six, :hearts),
        Card.new(:eight, :spades),
        Card.new(:ten, :clubs)
      ]

    cards2 =
      [
        Card.new(:two, :clubs),
        Card.new(:four, :spades),
        Card.new(:six, :hearts),
        Card.new(:eight, :spades),
        Card.new(:jack, :clubs)
      ]

    hand1 = Hand.new(cards1)
    hand2 = Hand.new(cards2) #winning

    expect(hand2 > hand1).to eq(true)
  end

  it "decides that a pair beats a high card" do
    cards1 =
    [
      Card.new(:two, :clubs),
      Card.new(:four, :spades),
      Card.new(:six, :hearts),
      Card.new(:eight, :spades),
      Card.new(:ace, :clubs)
    ]

    cards2 =
    [
      Card.new(:two, :clubs),
      Card.new(:two, :spades),
      Card.new(:six, :hearts),
      Card.new(:ten, :spades),
      Card.new(:jack, :clubs)
    ]

    hand1 = Hand.new(cards1)
    hand2 = Hand.new(cards2) #winning

    expect(hand2 > hand1).to eq(true)
  end

  it "decides that a higher pair beats a lower pair" do
    cards1 =
    [
      Card.new(:two, :clubs),
      Card.new(:two, :spades),
      Card.new(:six, :hearts),
      Card.new(:eight, :spades),
      Card.new(:ten, :clubs)
    ]

    cards2 =
    [
      Card.new(:three, :clubs),
      Card.new(:three, :spades),
      Card.new(:six, :hearts),
      Card.new(:eight, :spades),
      Card.new(:jack, :clubs)
    ]

    hand1 = Hand.new(cards1)
    hand2 = Hand.new(cards2) #winning

    expect(hand2 > hand1).to eq(true)
  end

  it "decides that two pair beat one pair" do
    cards1 =
    [
      Card.new(:ace, :clubs),
      Card.new(:ace, :spades),
      Card.new(:six, :hearts),
      Card.new(:eight, :spades),
      Card.new(:ten, :clubs)
    ]

    cards2 =
    [
      Card.new(:three, :clubs),
      Card.new(:three, :spades),
      Card.new(:four, :hearts),
      Card.new(:four, :spades),
      Card.new(:jack, :clubs)
    ]

    hand1 = Hand.new(cards1)
    hand2 = Hand.new(cards2) #winning

    expect(hand2 > hand1).to eq(true)
  end

  it "decides a higher two pair beats a lower two pair" do
    cards1 =
    [
      Card.new(:queen, :clubs),
      Card.new(:queen, :spades),
      Card.new(:king, :hearts),
      Card.new(:king, :spades),
      Card.new(:ten, :clubs)
    ]

    cards2 =
    [
      Card.new(:king, :clubs),
      Card.new(:king, :spades),
      Card.new(:ace, :hearts),
      Card.new(:ace, :spades),
      Card.new(:jack, :clubs)
    ]

    hand1 = Hand.new(cards1)
    hand2 = Hand.new(cards2) #winning

    expect(hand2 > hand1).to eq(true)
  end

  it "decides that a three of a kind beats a pair" do
    cards1 =
    [
      Card.new(:ace, :clubs),
      Card.new(:ace, :spades),
      Card.new(:six, :hearts),
      Card.new(:eight, :spades),
      Card.new(:ten, :clubs)
    ]

    cards2 =
    [
      Card.new(:two, :clubs),
      Card.new(:two, :spades),
      Card.new(:two, :hearts),
      Card.new(:eight, :spades),
      Card.new(:jack, :clubs)
    ]

    hand1 = Hand.new(cards1)
    hand2 = Hand.new(cards2) #winning

    expect(hand2 > hand1).to eq(true)
  end

  it "decides a higher three of a kind beats a lower three of a kind" do
    cards1 =
    [
      Card.new(:two, :clubs),
      Card.new(:two, :spades),
      Card.new(:two, :hearts),
      Card.new(:eight, :spades),
      Card.new(:ten, :clubs)
    ]

    cards2 =
    [
      Card.new(:three, :clubs),
      Card.new(:three, :spades),
      Card.new(:three, :hearts),
      Card.new(:eight, :spades),
      Card.new(:jack, :clubs)
    ]

    hand1 = Hand.new(cards1)
    hand2 = Hand.new(cards2) #winning

    expect(hand2 > hand1).to eq(true)
  end

  it "decides a straight beats a three of a kind" do
    cards1 =
    [
      Card.new(:ace, :clubs),
      Card.new(:ace, :spades),
      Card.new(:ace, :hearts),
      Card.new(:eight, :spades),
      Card.new(:ten, :clubs)
    ]

    cards2 =
    [
      Card.new(:two, :clubs),
      Card.new(:three, :spades),
      Card.new(:four, :hearts),
      Card.new(:five, :spades),
      Card.new(:six, :clubs)
    ]

    hand1 = Hand.new(cards1)
    hand2 = Hand.new(cards2) #winning

    expect(hand2 > hand1).to eq(true)
  end

  it "decides that a higher straight beats a lower straight" do
    cards1 =
    [
      Card.new(:ace, :clubs),
      Card.new(:two, :spades),
      Card.new(:three, :hearts),
      Card.new(:four, :spades),
      Card.new(:five, :clubs)
    ]

    cards2 =
    [
      Card.new(:two, :clubs),
      Card.new(:three, :spades),
      Card.new(:four, :hearts),
      Card.new(:five, :spades),
      Card.new(:six, :clubs)
    ]

    hand1 = Hand.new(cards1)
    hand2 = Hand.new(cards2) #winning

    expect(hand2 > hand1).to eq(true)
  end

  it "decides that a flush beats a straight" do

    cards1 =
    [
      Card.new(:two, :diamonds),
      Card.new(:three, :spades),
      Card.new(:four, :hearts),
      Card.new(:five, :spades),
      Card.new(:six, :diamonds)
    ]

    cards2 =
    [
      Card.new(:two, :clubs),
      Card.new(:four, :clubs),
      Card.new(:six, :clubs),
      Card.new(:eight, :clubs),
      Card.new(:ten, :clubs)
    ]

    hand1 = Hand.new(cards1)
    hand2 = Hand.new(cards2) #winning

    expect(hand2 > hand1).to eq(true)
  end

  it "decides that a higher flush beats a lower flush" do
    cards1 =
    [
      Card.new(:two, :clubs),
      Card.new(:four, :clubs),
      Card.new(:six, :clubs),
      Card.new(:eight, :clubs),
      Card.new(:ten, :clubs)
    ]

    cards2 =
    [
      Card.new(:two, :spades),
      Card.new(:four, :spades),
      Card.new(:six, :spades),
      Card.new(:eight, :spades),
      Card.new(:ten, :spades)
    ]

    hand1 = Hand.new(cards1)
    hand2 = Hand.new(cards2) #winning

    expect(hand2 > hand1).to eq(true)
  end

  it "decides a fullhouse beats a flush" do
    cards1 =
    [
      Card.new(:two, :clubs),
      Card.new(:four, :clubs),
      Card.new(:six, :clubs),
      Card.new(:eight, :clubs),
      Card.new(:ten, :clubs)
    ]

    cards2 =
    [
      Card.new(:two, :spades),
      Card.new(:two, :hearts),
      Card.new(:three, :spades),
      Card.new(:three, :hearts),
      Card.new(:three, :diamonds)
    ]

    hand1 = Hand.new(cards1)
    hand2 = Hand.new(cards2) #winning

    expect(hand2 > hand1).to eq(true)
  end

  it "decides that a higher fullhouse beats a lower fullhouse" do
    cards1 =
    [
      Card.new(:ace, :clubs),
      Card.new(:ace, :spades),
      Card.new(:king, :hearts),
      Card.new(:king, :spades),
      Card.new(:king, :clubs)
    ]

    cards2 =
    [
      Card.new(:king, :clubs),
      Card.new(:king, :spades),
      Card.new(:ace, :hearts),
      Card.new(:ace, :spades),
      Card.new(:ace, :clubs)
    ]

    hand1 = Hand.new(cards1)
    hand2 = Hand.new(cards2) #winning

    expect(hand2 > hand1).to eq(true)
  end

  it "decides that a four of a kind beats a fullhouse" do
    
    cards1 =
    [
      Card.new(:ace, :clubs),
      Card.new(:ace, :spades),
      Card.new(:ace, :hearts),
      Card.new(:king, :spades),
      Card.new(:king, :clubs)
    ]

    cards2 =
    [
      Card.new(:two, :clubs),
      Card.new(:two, :spades),
      Card.new(:two, :hearts),
      Card.new(:two, :diamonds),
      Card.new(:ten, :clubs)
    ]

    hand1 = Hand.new(cards1)
    hand2 = Hand.new(cards2) #winning

    expect(hand2 > hand1).to eq(true)

  end
  it "decides that a higher four of a kind beats a lower four of a kind" do
    cards1 =
    [
      Card.new(:king, :clubs),
      Card.new(:king, :spades),
      Card.new(:king, :hearts),
      Card.new(:king, :diamonds),
      Card.new(:ace, :clubs)
    ]

    cards2 =
    [
      Card.new(:ace, :clubs),
      Card.new(:ace, :spades),
      Card.new(:ace, :hearts),
      Card.new(:ace, :diamonds),
      Card.new(:two, :clubs)
    ]

    hand1 = Hand.new(cards1)
    hand2 = Hand.new(cards2) #winning

    expect(hand2 > hand1).to eq(true)
  end

  it "decides that straight flush beats a four of a kind" do
    cards1 =
    [
      Card.new(:king, :clubs),
      Card.new(:king, :spades),
      Card.new(:king, :hearts),
      Card.new(:king, :diamonds),
      Card.new(:ace, :clubs)
    ]

    cards2 =
    [
      Card.new(:two, :clubs),
      Card.new(:three, :clubs),
      Card.new(:four, :clubs),
      Card.new(:five, :clubs),
      Card.new(:ace, :clubs)
    ]

    hand1 = Hand.new(cards1)
    hand2 = Hand.new(cards2) #winning

    expect(hand2 > hand1).to eq(true)    
  end

  it "decides that a higher straight flush beats a lower straigh flush" do
    cards1 =
    [
      Card.new(:ace, :clubs),
      Card.new(:two, :clubs),
      Card.new(:three, :clubs),
      Card.new(:four, :clubs),
      Card.new(:five, :clubs)
    ]

    cards2 =
    [
      Card.new(:two, :diamonds),
      Card.new(:three, :diamonds),
      Card.new(:four, :diamonds),
      Card.new(:five, :diamonds),
      Card.new(:ace, :diamonds)
    ]

    hand1 = Hand.new(cards1)
    hand2 = Hand.new(cards2) #winning

    expect(hand2 > hand1).to eq(true)    
  end

  it "discards cards" do
    cards =
    [
      Card.new(:two, :diamonds),
      Card.new(:three, :diamonds),
      Card.new(:four, :diamonds),
      Card.new(:five, :diamonds),
      Card.new(:ace, :diamonds)
    ]

    hand = Hand.new(cards)
    chosen = cards[0..2]
    hand.discard(chosen)
    expect(hand.cards.length).to eq(2)
  end

  it "adds cards" do
    cards =
    [
      Card.new(:two, :diamonds),
      Card.new(:three, :diamonds),
      Card.new(:four, :diamonds),
      Card.new(:five, :diamonds),
      Card.new(:ace, :diamonds)
    ]

    cards2 =
    [
      Card.new(:two, :diamonds),
      Card.new(:three, :diamonds),
      Card.new(:four, :diamonds),
    ]

    hand = Hand.new(cards)
    chosen = cards[0..2]
    hand.discard(chosen)
    hand.add(cards2)
    expect(hand.cards.length).to eq(5)
  end

end
