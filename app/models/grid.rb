class Grid
  include Mongoid::Document

  field :letters, type: Array, default: []
end
