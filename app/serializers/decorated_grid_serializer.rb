class DecoratedGridSerializer < ActiveModel::Serializer
  attributes :id, :as_two_dimensional_array
  has_many :multipliers
end
