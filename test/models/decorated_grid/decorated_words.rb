require "test_helper"

class DecoratedGrid::DecoratedWords < ActiveSupport::TestCase
  setup do
    @grid = Grid.create({
      letters: "HAAH",
      words: [
        { word: "ha",  indices: [[0, 0], [0, 1]] },
        { word: "hah", indices: [[0, 0], [0, 1], [1, 1]] }
      ]
    })

    @decorated = DecoratedGrid.create grid: @grid
  end

  test "it decorates all the solved words on parent grid" do
    decorated_words = @decorated.words
    assert_equal(
      [
        {word: "ha", indices: [[0, 0], [0, 1]], value: 5},
        {word: "hah", indices: [[0, 0], [0, 1], [1, 1]], value: 11}
      ],
      @decorated.words
    )
  end
end