Rails.application.routes.draw do
  get "api/logs" => "logs#index"
  get "api/logs/:id" => "logs#show"
  post "api/logs" => "logs#create"
  get "api/places" => "places#index"
  post "api/places" => "places#create"
  get "api/matches" => "matches#index"
  get "api/matches/:id" => "matches#show"
  delete "api/matches/:id" => "matches#delete"
  post "api/matches" => "matches#create"
  get "api/opponents" => "opponents#index"
  post "api/opponents" => "opponents#create"
  get "api/opponents/:id" => "opponents#show"
  get "api/schools" => "schools#index"
  post "api/schools" => "schools#create"
  get "api/teams" => "teams#index"
  root to: "application#index"
  match "*path", to: "application#index", format: false, via: :get
end
