require 'test_helper'

class GridTest < ActiveSupport::TestCase
  test "has letters attribute" do
    grid = Grid.new
    assert grid.letters == nil
  end

  test "validates squareness" do
    grid = Grid.new letters: "ABC"
    assert_not grid.save, "grid needs to be square (3*3, 4*4, etc.)"

    grid.letters = "123456789"
    assert grid.save

    grid.letters = "1234567890123456"
    assert grid.save
  end
end
