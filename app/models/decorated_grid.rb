# DecoratedGrid represents a boggle grid complete with
# letter values and multipliers, etc.
#
class DecoratedGrid
  include Mongoid::Document

  belongs_to :grid, required: true

  embeds_many :multipliers

  validates_presence_of :grid_id
  validate :grid_is_solved

  def as_two_dimensional_array
    grid.as_two_dimensional_array.each_with_index.map do |row, y|
      row.each_with_index.map do |letter, x|
        Letter.new(
          letter: letter,
          x: x,
          y: y,
          letter_multiplier: multipliers.letter.indices(x,y).first&.value,
          word_multiplier: multipliers.word.indices(x,y).first&.value
        ).as_json
      end
    end
  end

  private

  def grid_is_solved
    unless grid && grid.words
      errors.add :grid, "must be solved before any decorated grids can be derived."
    end
  end
end
