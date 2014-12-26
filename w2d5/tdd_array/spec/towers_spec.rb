require 'towers'

describe Towers do
  subject(:game) { Towers.new }
  it "starts the game with all disks on the first peg" do
    expect(game.pegs[0]).to match_array([3,2,1])
  end
  it "can move any disk to an empty peg" do
    game.move(0, 1)
    game.move(0, 2)
    expect(game.pegs).to match_array([[3],[1],[2]])
  end

  it "lets player move a lighter disc on top of a heavier one" do
    game.move(0, 1)
    game.move(0, 2)
    game.move(1, 2)
    expect(game.pegs).to match_array([[3],[],[2,1]])
  end

  it "does not let a heavier disk be placed on a lighter one" do
    game.move(0, 1)
    game.move(0, 2)

    expect do
      game.move(2, 1)
    end.to raise_error(InvalidMoveError, "Invalid Move!")
  end

  it "ends the game if all disks are on the third peg" do
    expect(game).to receive(:won_game)
    game.move(0, 2)
    game.move(0, 1)
    game.move(2, 1)
    game.move(0, 2)
    game.move(1, 0)
    game.move(1, 2)
    game.move(0, 2)
  end
end
