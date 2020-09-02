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
    hogehoge = params['_json']
    p hogehoge
    logs = []    
    # 5.times do |i|
    #   logs << Log.new(
    #     team_id: hogehoge[i][:team_id], 
    #     opponent_id: hogehoge[i][:opponent_id],
    #     match_id: hogehoge[i][:match_id],
    #     my_kimete: hogehoge[i][:my_kimete],
    #     aite_kimete: hogehoge[i][:aite_kimete],
    #     position: hogehoge[i][:position]
    #   )
    # end
    # Log.import logs, on_duplicate_key_update: [:team_id, :opponent_id, :my_kimete, :aite_kimete, :position]
    # render json: logs
  end

  # def log_params
  #   params.permit('_json': [:team_id, :opponent_id, :match_id, :my_kimete, :aite_kimete, :position, :name])
  # end
end
