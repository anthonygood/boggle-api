class DecoratedGridSerializer < ActiveModel::Serializer
  attribute(:board)       { object.as_two_dimensional_array }
  attribute(:paths_count) { object.words.count }
  attribute(:word_count)  { dictionary.count }

  # Includes duplicate words (ie. words of different paths)
  attribute :words

  # Just the strings in an array
  attribute :dictionary

  # TODO:
  # Refine this value to exclude duplicate words
  attribute(:total_score) { object.words.sum {|word| word[:score] } }

  def dictionary
    object.words.map {|word| word[:word] }.uniq.sort
  end
end
