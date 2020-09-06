class MatchesController < ApplicationController
  def index
    matches = Match.all
    render json: matches.map {|n| {
      id: n.id,
      school_name: n.school.name,
      place_name: n.place.name,
      create_date: n.created_at
    }}
  end
  def show
    @match = Match.where(id: params[:id])
    render json: @match.map {|n| {
      school_id: n.school.id,
      school_name: n.school.name,
      place_name: n.place.name,
      create_date: n.created_at
    }}[0]
  end
  def delete
    @match = Match.find(params[:id])
    @match.destroy
    render json: @match
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
