class PlacesController < ApplicationController
  def index
    places = Place.select(:id, :name)
    render json: places
  end
  def create
    place = Place.new(place_params)
    if place.save
      render json: place
    else
      render json: place.errors
    end
  end
  private
  def place_params
    p params
    params.require(:place).permit(:name)
  end
end
