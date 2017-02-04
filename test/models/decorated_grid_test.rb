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

  class AsTwoDimensionalArray < ActiveSupport::TestCase
    setup do
      @grid = Grid.create letters: "ABCD", words: []
      @decorated = DecoratedGrid.create grid: @grid
    end

    test "#as_two_dimensional_array" do
      letter = @decorated.as_two_dimensional_array[1][0]

      assert_equal(
        {letter: "c", x: 0, y: 1, base_value: 3, value: 3, letter_multiplier: 1, word_multiplier: 1},
        letter
      )
    end

    test "applies multipliers" do
      # Apply triple letter score to "D"
      @decorated.multipliers.create x: 1, y: 1, value: 3

      # Apply quintuple word score to "B"
      @decorated.multipliers.create x: 1, y: 0, value: 5, acts_upon: :word

      array = @decorated.as_two_dimensional_array

      assert_equal(
        {letter: "d", x: 1, y: 1, base_value: 2, value: 6, letter_multiplier: 3, word_multiplier: 1},
        array[1][1]
      )

      assert_equal(
        {letter: "b", x: 1, y: 0, base_value: 3, value: 3, letter_multiplier: 1, word_multiplier: 5},
        array[0][1]
      )
    end
  end
end
