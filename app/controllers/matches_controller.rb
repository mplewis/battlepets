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

    # Run performances for each pet asynchronously. The match is complete when all performances are complete.
    base_config = config['all']
    pets.each do |pet|
      perf = Performance.new pet: pet, match: @match
      perf.save!
      PetEvaluator.evaluate_pet(perf, base_config, pet, contest)
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

end
