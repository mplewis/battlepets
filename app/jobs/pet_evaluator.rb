class PetEvaluator
  class << self
    def evaluate_pet(perf, base_config, pet, contest)
      # The pet evaluation process takes a while. Each evaluation takes from 0 to 5 seconds and runs asynchronously.
      sleep rand(0) * 5
      perf.score = score_pet base_config, pet, contest
      perf.complete = true
      perf.save!
    end

    private

    # Score a pet's performance in a specific type of match
    def score_pet(base_config, pet, contest)

      score = 0
      # A contest is made of attrs to check and a multiplier to apply on top of the base value
      contest.each do |attr, multiplier|
        # Get the pet's attribute value
        getter = attr.to_sym
        mean = pet.send(getter)

        # Add the variance and generate the performance using a Gaussian distribution
        sigma = base_config['variance']
        gauss_gen = Distribution::Normal.rng mean, sigma
        attr_score = gauss_gen.call

        # Multiply by how significant this attribute is in this contest and add to the score
        score += attr_score * multiplier
      end
      # Return the final score
      score
    end

    handle_asynchronously :evaluate_pet
  end
end
