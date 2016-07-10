class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :destroy]

  # GET /matches
  # GET /matches.json
  def index
    @matches = Match.all

    render json: @matches
  end

  # GET /matches/1
  # GET /matches/1.json
  def show
    render json: @match
  end

  # POST /matches
  # POST /matches.json
  def create
    @match = Match.new

    # Set the match type and verify it's a valid type
    config = YAML.load_file Rails.root.join('config/contest.yml')
    contests = config['contests']
    type = params[:type]
    contest = contests[type]
    if contest.nil?
      error = {'error': "Match type '#{type}' not found in known types: #{contests.keys}"}
      render json: error, status: :unprocessable_entity
      return
    end
    @match.contest = type

    # Retrieve pet objects for all IDs
    pets = []
    params[:pets].each do |id|
      begin
        pets << Pet.find(id)
      rescue ActiveRecord::RecordNotFound
        render json: {error: "No pet found for ID '#{id}'"}, status: :unprocessable_entity
        return
      end
    end

    # Run performances for each pet
    base_config = config['all']
    pets.each do |pet|
      perf = Performance.new
      perf.pet = pet
      perf.match = @match
      perf.score = score_pet base_config, pet, contest
      perf.save
    end

    if @match.save
      render json: @match, status: :created, location: @match
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @match.destroy

    head :no_content
  end

  private

  def set_match
    @match = Match.find(params[:id])
  end

  def match_params
    params.require(:match).permit(:type, :pets)
  end

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
end
