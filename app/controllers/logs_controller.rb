class LogsController < ApplicationController
  before_action :set_log, only: [:show]
  def index
    logs = Log.all.select
    render json: logs
  end
  def show
    render json: @log
  end
  def create
    hogehoge = params['_json']
    p 'hogehoge'
    logs = []    
    5.times do |i|
      logs << Log.new(
        team_id: hogehoge[i][:team_id], 
        opponent_id: hogehoge[i][:opponent_id],
        match_id: hogehoge[i][:match_id],
        my_kimete: hogehoge[i][:my_kimete],
        aite_kimete: hogehoge[i][:aite_kimete],
        position: hogehoge[i][:position]
      )
    end
    Log.import logs, on_duplicate_key_update: [:team_id, :opponent_id, :my_kimete, :aite_kimete, :position]
    render json: logs
  end
  private
  def set_log
    @log = Log.all.where(match_id: params[:id])
  end

  def log_params
    params.permit('_json': [:team_id, :opponent_id, :match_id, :my_kimete, :aite_kimete, :position])
  end
end
