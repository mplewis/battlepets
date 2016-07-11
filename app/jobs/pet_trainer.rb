class PetTrainer
  class << self
    # Train a pet using the base training config and a specific regimen
    def train_pet(pet, base_config, regimen)
      # A regimen is made of attrs to modify and a multiplier to apply on top of the base gains
      regimen.each do |attr, multiplier|
        # Gaussian distribution is used to figure out how many points are gained
        mean = base_config['base_gain'] * multiplier
        sigma = base_config['variance'] * multiplier

        # Get the original attribute value
        getter = attr.to_sym
        attr_start = pet.send getter

        # Get the new attribute value
        gauss_gen = Distribution::Normal.rng mean, sigma
        attr_change = gauss_gen.call  # Get the normally distributed gains
        attr_change = attr_change.ceil  # Round up
        attr_change = 0 if attr_change < 0  # Ensure non negative
        attr_end = attr_start + attr_change

        # Set the new value
        setter = "#{attr}=".to_sym
        pet.send setter, attr_end
        pet.save!
      end
    end
  end
end