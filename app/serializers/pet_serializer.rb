class PetSerializer < ActiveModel::Serializer
  attributes :id, :name, :wins, :losses, :experience, :stats

  def stats
    {strength: object.strength,
     agility: object.agility,
     wit: object.wit,
     perception: object.perception}
  end
end
