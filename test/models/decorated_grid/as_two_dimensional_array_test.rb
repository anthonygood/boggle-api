require "test_helper"

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
