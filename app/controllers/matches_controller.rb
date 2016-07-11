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
    render json: match
  end

  # POST /matches
  # POST /matches.json
  def create
    type = params[:type]
    pet_ids = params[:pets]
    result = MatchRunner.new_match type, pet_ids

    error = result[:error]
    save_errors = result[:save_errors]
    match = result[:match]

    if error == :no_pet_found
      id = result[:id]
      render json: {error: "No pet found for ID '#{id}'"}, status: :unprocessable_entity
    elsif error == :unknown_type
      type = result[:type]
      known = result[:known]
      error = {'error': "Match type '#{type}' not found in known types: #{known}"}
      render json: error, status: :unprocessable_entity
    elsif save_errors
      render json: save_errors, status: :unprocessable_entity
    else
      render json: match, status: :created, location: match
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    match.destroy

    head :no_content
  end

  private

  def set_match
    match = Match.find(params[:id])
  end

  def match_params
    params.require(:match).permit(:type, :pets)
  end

end
