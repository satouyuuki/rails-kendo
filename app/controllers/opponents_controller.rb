class OpponentsController < ApplicationController
  before_action :set_opponent, only: [:show]
  def index
    opponents = Opponent.all
    render json: opponents
  end
  def show
    render json: @opponent
  end
  private
  def set_opponent
    @opponent = Opponent.where(school_id: params[:id])
  end
end
