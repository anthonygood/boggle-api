class DecoratedGridSerializer < ActiveModel::Serializer
  attribute(:board) { object.as_two_dimensional_array }
  attribute(:word_count) { object.words.count }
  attributes :words
  attribute(:total_score) { object.words.sum {|word| word[:score] } }

  def total_score
    words
  end
end
