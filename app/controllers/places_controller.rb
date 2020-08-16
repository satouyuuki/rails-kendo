class PlacesController < ApplicationController
  def index
    places = Place.all
    render json: places
  end
end
