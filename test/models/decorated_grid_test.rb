require "test_helper"

class DecoratedGridTest < ActiveSupport::TestCase
  setup do
    @grid = Grid.create
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
    @decorated.multipliers.create! row_index: 0, letter_index: 0

    multi = @decorated.multipliers.first
    assert_equal 2, multi.value
    assert_equal :letter, multi.acts_upon
  end
end
