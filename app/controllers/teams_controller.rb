class TeamsController < ApplicationController
  def index
    teams = Team.all.select(:id, :name)
    render json: teams
  end
end
