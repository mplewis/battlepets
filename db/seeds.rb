pets = 20
max_trainings = 20
matches = 10

pb = ProgressBar.create title: 'Creating pets', total: pets
pets.times do
  Pet.new.save!
  pb.increment
end

config = YAML.load_file Rails.root.join('config/training.yml')
base_config = config['all']
pb = ProgressBar.create title: 'Training pets', total: Pet.count
pets.times do
  Pet.find_each do |p|
    trainings = rand max_trainings
    trainings.times do
      regimen_name = config['regimens'].keys.sample
      regimen = config['regimens'][regimen_name]
      PetTrainer.train_pet p, base_config, regimen
    end
  end
  pb.increment
end

pet_ids = Pet.pluck :id
config = YAML.load_file Rails.root.join('config/contest.yml')
pb = ProgressBar.create title: 'Holding matches', total: matches
matches.times do
  type = config['contests'].keys.sample
  MatchRunner.new_match type, pet_ids
  pb.increment
end

puts "Don't forget to run `rake jobs:work` to finish evaluating the matches."
