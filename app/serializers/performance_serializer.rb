class PerformanceSerializer < ActiveModel::Serializer
  attributes :id, :name, :score

  def name
    object.pet.name
  end
end
