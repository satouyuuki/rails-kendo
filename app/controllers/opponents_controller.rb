class OpponentsController < ApplicationController
  before_action :set_opponent, only: [:show]
  def index
    opponents = Opponent.all.select(:id, :name)
    render json: opponents
  end
  def show
    render json: @opponent
  end
  private
  def set_opponent
    @opponent = Opponent.all.select(:id, :name).where(school_id: params[:id])
  end
end
