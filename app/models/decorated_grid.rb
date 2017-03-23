# DecoratedGrid represents a boggle grid complete with
# letter values and multipliers, etc.
#
class DecoratedGrid
  include Mongoid::Document

  belongs_to :grid, required: true

  embeds_many :multipliers

  validates_presence_of :grid_id
  validate :grid_is_solved

  # TODO: refactor decorating logic into GridDecorator class.
  def as_two_dimensional_array
    @as_two_dimensional_array ||= grid.as_two_dimensional_array.each_with_index.map do |row, y|
      row.each_with_index.map do |letter, x|
        Letter.new(
          letter: letter,
          x: x,
          y: y,
          letter_multiplier: multipliers.letter.indices(x,y).first&.value,
          word_multiplier: multipliers.word.indices(x,y).first&.value
        )
      end
    end
  end

  alias :as_json :as_two_dimensional_array

  # Return the words from parent grid, decorated with score.
  def words
    grid.words.map {|word| decorate_word(word) }
  end

  private

  def grid_is_solved
    unless grid && grid.words
      errors.add :grid, "must be solved before any decorated grids can be derived."
    end
  end

  # TODO: refactor decorating logic into GridDecorator class.
  def decorate_word(word)
    word_multiplier = 1

    # Word looks something like:
    # { word: "ha",  indices: [[0, 0], [0, 1]] }
    # Return the word's score, while also checking for any word multipliers.
    score = word["indices"].reduce(0) do |word_value, index|
      y, x = index

      this_letter = self.as_two_dimensional_array[y][x]

      # Is there a bigger word multiplier?
      if this_letter.word_multiplier > word_multiplier
        word_multiplier = this_letter.word_multiplier
      end

      # Return the value of the decorated letter at this index.
      word_value += this_letter.value
    end

    word.merge(
      base_score: score,
      multiplier: word_multiplier,
      score: score * word_multiplier
    )
  end
end
