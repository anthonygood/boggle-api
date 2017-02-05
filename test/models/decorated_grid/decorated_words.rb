require "test_helper"

class DecoratedGrid::DecoratedWords < ActiveSupport::TestCase
  setup do
    @ha  = { word: "ha",  indices: [[0, 0], [0, 1]]         }
    @hah = { word: "hah", indices: [[0, 0], [0, 1], [1, 1]] }

    @grid = Grid.create({
      letters: "HAAH",
      words: [@ha, @hah]
    })

    @decorated = DecoratedGrid.create grid: @grid
  end

  test "it decorates all the solved words on parent grid" do
    words = @decorated.words
    assert_equal(
      [
        @ha.merge(base_score: 5, score: 5, multiplier: 1),
        @hah.merge(base_score: 9, score: 9, multiplier: 1)
      ],
      words
    )
  end

  # With multipliers, base_score (for words) and base_value (for letters)
  # refer to the value of the item before *its own* multipliers are applied.
  # That is, if all a word's letters have multipliers, but the word itself
  # has no word multiplier, the word's base_score and actual score will be the same.
  # eg.
  #
  # cat = [C*2][A*2][T*2]      (All double letter multipliers,
  # cat.base_score = [6][2][2]  but no word multiplier.)
  # cat.base_score = 10
  # cat.score      = 10
  #
  # cat = [C*1][A*1][T*1,2w]   (2w == double word multiplier)
  # cat.base_score = [3][1][1] (base_score ignores word multipliers)
  # cat.base_Score = 5
  # cat.score      = 10
  #
  # Also, only one word multiplier is applied. If a word contains multiple
  # word multipliers, only the greatest has effect.
  #
  test "it applies multipliers" do
    # Double letter score on first H
    @decorated.multipliers.create! x: 0, y: 0, value: 2

    # Decuple word score on last H
    @decorated.multipliers.create! x: 1, y: 1, value: 10, acts_upon: :word

    words = @decorated.words
    ha    = words.first
    hah   = words.second

    assert_equal @ha.merge(base_score: 9, score: 9, multiplier: 1), ha
    assert_equal @hah.merge(base_score: 13, score: 130, multiplier: 10), hah
  end
end