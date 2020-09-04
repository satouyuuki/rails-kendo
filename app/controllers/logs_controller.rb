class LogsController < ApplicationController
  def index
    logs = Log.all.select
    render json: logs
  end
  def show
    # jbuilder eger-load
    @logs = Log.where(match_id: params[:id])
    # ログモデルのインスタンス
    # [1,2,3] => [2,4,6]
    # [1,2,3].map {|n| n*2}
    render json: @logs.map {|n| {
      t_name: n.team.name, 
      o_name: n.opponent.name, 
      o_school: n.match.school.name, 
      place: n.match.place.name, 
      match_id: n.match_id,
      opponent_id: n.opponent_id,
      team_id: n.team_id,
      position: n.position,
      my_kimete: n.my_kimete,
      aite_kimete: n.aite_kimete,
    }}
  end
  def create
    logData = params['_json']
    logs = []    
    logData.each do |item|
      logs << Log.new(
        team_id: item[:team_id], 
        opponent_id: item[:opponent_id],
        match_id: item[:match_id],
        my_kimete: item[:my_kimete],
        aite_kimete: item[:aite_kimete],
        position: item[:position]
      )
    end
    Log.import logs, on_duplicate_key_update: [:my_kimete, :aite_kimete]
    render json: logs
  end

  # def log_params
  #   params.permit('_json': [:team_id, :opponent_id, :match_id, :my_kimete, :aite_kimete, :position, :name])
  # end
end
