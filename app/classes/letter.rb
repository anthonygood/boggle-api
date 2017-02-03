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
end
