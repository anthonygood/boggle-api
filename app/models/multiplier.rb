# Simple embedded document to represent a multiplier for a boggle grid.
# Eg. triple word score, or double letter score
#
class Multiplier
  include Mongoid::Document

  embedded_in :decorated_grid

  field :y, type: Integer # row index
  field :x, type: Integer # column index

  field :value, type: Integer, default: 2
  field :acts_upon, type: Symbol, default: :letter

  validate :correct_acted_upon

  private

  def correct_acted_upon
    unless [:letter, :word].include? acts_upon
      errors.add :acts_upon, "must be either :letter or :word"
    end
  end
end
