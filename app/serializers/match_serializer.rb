class MatchSerializer < ActiveModel::Serializer
  attributes :id, :complete, :winner, :progress
  has_many :performances

  def winner
    {id: object.winner.pet.id,
     name: object.winner.pet.name,
     score: object.winner.score}
  end

  def progress
    {complete: object.performances.where(complete: true).count,
     incomplete: object.performances.where(complete: false).count}
  end

end
