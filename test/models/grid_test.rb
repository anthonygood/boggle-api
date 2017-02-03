require "test_helper"

class GridTest < ActiveSupport::TestCase
  @letters = "ABCDEFGHI"

  test "generates random letters before validation" do
    grid = Grid.create

    refute_equal grid.letters, nil, "random letters should be selected for each new grid"
  end

  test "it accepts letters argument" do
    grid = Grid.new letters: "hah"

    assert_equal grid.letters, "hah"
  end

  test "validates squareness" do
    grid = Grid.new letters: "ABC"
    assert_not grid.save, "grid needs to be square (3*3, 4*4, etc.)"

    grid.letters = "123456789"
    assert grid.save

    grid.letters = "1234567890123456"
    assert grid.save
  end

  test "#as_grid" do
    grid = Grid.new letters: "CAAT"

    array = grid.send :as_two_dimensional_array

    assert_equal array, [["C","A"],["A","T"]]
  end
end
