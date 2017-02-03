# DecoratedGrid represents a boggle grid complete with letter values,
# and any bonus multipliers, etc.
class DecoratedGrid
  include Mongoid::Document

  belongs_to :grid
end
