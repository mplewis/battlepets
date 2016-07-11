require 'faker'
require 'distribution'

class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :update, :destroy, :train]

  # GET /pets
  # GET /pets.json
  def index
    @pets = Pet.all

    render json: @pets
  end

  # GET /pets/1
  # GET /pets/1.json
  def show
    render json: @pet
  end

  # POST /pets
  # POST /pets.json
  def create
    @pet = Pet.new

    if @pet.save
      render json: @pet, status: :created, location: @pet
    else
      render json: @pet.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pets/1
  # PATCH/PUT /pets/1.json
  def update
    @pet = Pet.find(params[:id])

    if @pet.update(pet_params)
      head :no_content
    else
      render json: @pet.errors, status: :unprocessable_entity
    end
  end

  # DELETE /pets/1
  # DELETE /pets/1.json
  def destroy
    @pet.destroy

    head :no_content
  end

  # POST /pets/1/train
  # POST /pets/1/train.json
  # Train a pet. Body: {"training": "type": "SOME_REGIMEN"}
  # Regimens are defined in config/training.yml
  def train
    config = YAML.load_file Rails.root.join('config/training.yml')
    params.require(:training).permit(:type)

    type = params['training']['type']
    regimens = config['regimens']
    regimen = regimens[type]
    if regimen.nil?
      error = {'error': "Training regimen '#{type}' not found in known regimens: #{regimens.keys}"}
      render json: error, status: :unprocessable_entity
      return
    end

    base_config = config['all']
    PetTrainer.train @pet, base_config, regimen

    render json: @pet
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :strength, :agility, :wit, :perception)
  end
end
