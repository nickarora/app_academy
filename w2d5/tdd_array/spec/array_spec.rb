require 'array'

describe "Array - new methods" do
  it "removes duplicates of an array" do
    arr = [1,2,1,3,3]
    expect(arr.my_uniq).to contain_exactly(1,2,3)
  end

  it "finds pairs of positions that sum to zero" do
    arr = [-1, 0, 2, -2, 1]
    expect(arr.two_sum).to match_array([[0,4], [2,3]])
  end

end
