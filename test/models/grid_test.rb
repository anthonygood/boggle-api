require "test_helper"

class GridTest < ActiveSupport::TestCase
  @letters = "ABCDEFGHI"

  test "generates random letters before validation" do
    grid = Grid.create

    refute_equal nil, grid.letters, "random letters should be selected for each new grid"
  end

  test "it accepts letters argument" do
    grid = Grid.new letters: "hah"

    assert_equal "hah", grid.letters
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
    grid = Grid.create letters: "CAAT"

    array = grid.send :as_two_dimensional_array

    assert_equal [["c","a"],["a","t"]], array
  end

  test "#words" do
    # Skip solving the grid
    Boggle::Solver.stub :find_words!, [[{hello: true}],[{goodbye: true}]] do

      grid = Grid.create letters: "CAAT"
      assert_nil grid.words, "by default, grids are unsolved"

      grid.solve!
      grid.reload

      solution = grid.words

      assert_equal 2, solution.length
    end
  end
end
