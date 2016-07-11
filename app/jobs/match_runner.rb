class MatchRunner
  class << self
    def new_match(type, pet_ids)
      match = Match.new

      # Set the match type and verify it's a valid type
      config = YAML.load_file Rails.root.join('config/contest.yml')
      contests = config['contests']
      contest = contests[type]
      if contest.nil?
        return {error: :unknown_type, type: type, known: contests.keys}
      end
      match.contest = type

      # Retrieve pet objects for all IDs
      pets = []
      pet_ids.each do |id|
        begin
          pets << Pet.find(id)
        rescue ActiveRecord::RecordNotFound
          # return
          return {error: :no_pet_found, id: id}
        end
      end

      # Run performances for each pet asynchronously. The match is complete when all performances are complete.
      base_config = config['all']
      pets.each do |pet|
        perf = Performance.new pet: pet, match: match
        perf.save!
        PetEvaluator.evaluate_pet(perf, base_config, pet, contest)
      end

      if match.save
        {match: match}
      else
        {match: match, save_errors: match.errors}
      end
    end
  end
end