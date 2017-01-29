class Grid
  include Mongoid::Document

  field :letters, type: String

  validate :letters_represent_square

  def letters_represent_square
    count = letters.length
    unless count > 0 && Math.sqrt(count).to_i == Math.sqrt(count)
      errors.add :letters, "must represent a square (#{count} is not a square number!"
    end
  end
end
