class OpponentsController < ApplicationController
  before_action :set_opponent, only: [:show]
  def index
    opponents = Opponent.select(:id, :name)
    render json: opponents
  end
  def show
    render json: @opponent
  end
  def create
    datas = params['_json']
    opponents = []    
    datas.each do |item|
      opponents << Opponent.new(
        school_id: item[:school_id], 
        name: item[:name],
      )
    end
    Opponent.import opponents
    render json: opponents
  end

  private
  def set_opponent
    @opponent = Opponent.all.select(:id, :name).where(school_id: params[:id])
  end
end
