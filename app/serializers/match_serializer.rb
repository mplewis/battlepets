class MatchSerializer < ActiveModel::Serializer
  attributes :id, :winner
  has_many :performances
end
