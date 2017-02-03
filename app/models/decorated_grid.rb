# DecoratedGrid represents a boggle grid complete with
# letter values and multipliers, etc.
#
class DecoratedGrid
  include Mongoid::Document

  belongs_to :grid

  embeds_many :multipliers
end
