require 'my_transpose'

describe "my_transpose" do

  it "tranposes an array" do
    rows = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ]

    solution = [[0, 3, 6],
                [1, 4, 7],
                [2, 5, 8]]

    expect(my_transpose(rows)).to match_array(solution)
  end

end
