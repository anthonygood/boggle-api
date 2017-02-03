# DecoratedGrid represents a boggle grid complete with
# letter values and multipliers, etc.
#
class DecoratedGrid
  include Mongoid::Document

  belongs_to :grid

  embeds_many :multipliers

  def as_two_dimensional_array
    grid.as_two_dimensional_array.each_with_index.map do |row, y|
      row.each_with_index.map do |letter, x|
        Letter.new(letter, x, y).as_json
      end
    end
  end
end
