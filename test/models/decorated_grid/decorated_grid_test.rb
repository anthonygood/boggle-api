require "test_helper"

class DecoratedGridTest < ActiveSupport::TestCase
  setup do
    @grid = Grid.create letters: "HAAH", words: [{word:"ha"}] # Supply dummy words
                                                              # to avoid solving
    @decorated = DecoratedGrid.create grid: @grid
  end

  test "belongs_to grid" do
    assert_equal @grid, @decorated.grid
  end

  test "requires grid" do
    unrelated_grid = DecoratedGrid.new
    refute unrelated_grid.save, "decorated grid depends on grid"
  end

  test "cannot belong to unsolved grid" do
    grid = Grid.create letters: "BOOH"

    decorated = DecoratedGrid.new grid: grid

    refute decorated.save, "decorated grid shouldn't belong to an unsolved grid"
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
end
