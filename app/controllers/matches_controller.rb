class MatchesController < ApplicationController
  def index
    matches = Match.all
    render json: matches
  end
end
