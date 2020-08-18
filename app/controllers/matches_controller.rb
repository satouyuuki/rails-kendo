class MatchesController < ApplicationController
  def index
    matches = Match.all
    render json: matches
  end
  def create
    match = Match.new(match_params)
    if match.save
      render json: match
    else
      render json: match.errors
    end
  end
  private
  def match_params
    params.require(:match).permit(:school_id, :place_id)
  end
end
