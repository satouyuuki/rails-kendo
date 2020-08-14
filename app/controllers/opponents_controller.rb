class OpponentsController < ApplicationController
  def index
    opponents = Opponent.all
    render json: opponents
  end
end
