class PerformanceSerializer < ActiveModel::Serializer
  attributes :id, :name, :score

  def id
    object.pet.id
  end

  def name
    object.pet.name
  end
end
