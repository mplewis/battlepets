class Pet < ActiveRecord::Base

  before_create :set_initial_values

  has_many :performances

  def set_initial_values
    if rand(10) == 0
      self.name = Faker::StarWars.character
    else
      self.name = Faker::Name.first_name
    end
    self.strength = initial_attribute
    self.agility = initial_attribute
    self.wit = initial_attribute
    self.perception = initial_attribute
  end

  private

  def initial_attribute
    rand(2..9)
  end

end
