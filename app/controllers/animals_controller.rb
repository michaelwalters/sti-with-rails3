class AnimalsController < ApplicationController
  include AnimalsHelper

  before_filter :set_animal, only: [:show, :edit, :update, :destroy]
  before_filter :set_race

  def index
    @animals = race_class.all
  end

  def show
  end

  def new
    @animal = race_class.new
  end

  def edit
  end

  def create
    @animal = Animal.new(animal_params)

    if @animal.save
      redirect_to @animal, notice: "#{race} was successfully created."
    else
      render action: 'new'
    end
  end

  def update
    update_params = animal_params
    if @animal.update_attributes(update_params)
      redirect_to @animal, notice: "#{race} was successfully created."
    else
      render action: 'edit'
    end
  end


  def destroy
    @animal.destroy
    redirect_to animals_url
  end

  # ##############################
  #  PRIVATE METHODS!
  # ##############################
  private

  def set_race
    @race = race
  end

  def race
    Animal.races.include?(params[:type]) ? params[:type] : "Animal"
  end

  def race_class
    # +constantize+ tries to find a declared constant with the name specified
    # in the string. It raises a NameError when the name is not in CamelCase
    # or is not initialized.  See ActiveSupport::Inflector.constantize
    race.constantize
  end

  def set_animal
    @animal = race_class.find(params[:id])
  end

  def animal_params
    underscore_race = underscore(race)
    params.require(underscore_race).permit(:name, :race, :age)
  end

end
