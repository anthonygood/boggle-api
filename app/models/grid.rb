# A pure, undecorated Grid of letters (no multipliers, etc.)
class Grid
  include Mongoid::Document

  GRID_SIZE = 16

  field :letters, type: String
  field :grid, type: Array, default: []

  has_many :decorated_grid, dependent: :destroy

  validate :letters_represent_square
  before_validation :generate_grid

  def generate_grid
    self.letters = letters || Boggle::LetterPicker.pick_letters(GRID_SIZE)
  end

  private

  def letters_represent_square
    count = letters&.length
    unless count && count > 0 && Math.sqrt(count).to_i == Math.sqrt(count)
      errors.add :letters, "must represent a square (#{count} is not a square number!"
    end
  end

  def sqrt
    Math.sqrt(letters.length).to_i
  end

  def as_two_dimensional_array
    letters_as_rows.map do |row|
      row.split("")
    end
  end

  def letters_as_rows
    letters.scan /\w{#{sqrt}}/
  end
end
