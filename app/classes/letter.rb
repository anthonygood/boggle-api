# A letter's X and Y values refer to the letter's indices
# in the two dimensional array, where Y is the primary index,
# and X the secondary index.
#
# You can also think of Y as the row or vertical index,
# and X as the column or horizontal index, a bit like co-ordinates.
#
# So in the following grid:
#   [
#     [A,B],
#     [C,D]
#   ]
# The letter C would be accessed with bracket notation as `grid[1][0]`,
# and therefore has X/Y values of {x: 0, y: 1}.
#
class Letter
  def initialize(letter, x, y)
    @letter, @x, @y = letter, x, y
  end

  def as_json
    {
      letter: @letter,
      x: @x,
      y: @y,
      value: 1,
      multiplier: 1
    }
  end

  private

  def value
    case letter
    when "d", "g"
      2
    when "b", "c", "m", "p"
      3
    when "f", "h", "v", "w", "y"
      4
    when "k"
      5
    when "j", "x"
      8
    when "qu", "z"
      10
    else
      1
    end
  end
end
