require "test_helper"

class DecoratedGridTest < ActiveSupport::TestCase
  setup do
    @grid = Grid.create letters: "HAAH"
    @decorated = DecoratedGrid.create grid: @grid
  end

  test "belongs_to grid" do
    assert_equal @grid, @decorated.grid
  end

  test "is dependent: destroy upon grid" do
    @grid.destroy

    assert_raises(Mongoid::Errors::DocumentNotFound) { @decorated.reload }
  end

  test "has multipliers" do
    @decorated.multipliers.create! y: 0, x: 0

    multi = @decorated.multipliers.first
    assert_equal 2, multi.value
    assert_equal :letter, multi.acts_upon
  end

  test "#as_two_dimensional_array" do
    array = @decorated.as_two_dimensional_array
    letter = array[1][0]

    assert_equal(
      {letter: "a", x: 0, y: 1, value: 1, multiplier: 1},
      letter
    )
  end

  test "#multipliers_at" do
    multi = @decorated.multipliers.create x: 1, y: 0

    assert_nil @decorated.multipliers_at(0,0), "should return nil if no multiplier exists for indices"
    assert_equal multi, @decorated.multipliers_at(1,0)
  end
end
