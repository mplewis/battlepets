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
  def train
    config = YAML.load_file Rails.root.join('config/training.yml')
    params.require(:training).permit(:type)

    type = params['training']['type']
    regimens = config['regimens']
    regimen = regimens[type]
    if regimen.nil?
      error = {'error': "Training regimen '#{type}' not found in known regimens: #{regimens.keys}"}
      render json: error, status: :bad_request
      return
    end

    base_config = config['all']
    perform_training base_config, regimen

    render json: @pet
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def perform_training(base_config, regimen)
    puts @pet, regimen
    regimen.each do |attr, multiplier|
      getter = attr.to_sym
      attr_start = @pet.send getter

      mean = base_config['base_gain'] * multiplier
      sigma = base_config['variance'] * multiplier

      gauss_gen = Distribution::Normal.rng mean, sigma
      attr_change = gauss_gen.call
      attr_change = attr_change.ceil
      attr_change = 0 if attr_change < 0

      setter = "#{attr}=".to_sym
      attr_end = attr_start + attr_change

      puts "#{attr}: #{attr_start} -> #{attr_end}"
      @pet.send setter, attr_end
      @pet.save!
    end
  end
end
