Rails.application.routes.draw do
  get "api/logs" => "logs#index"
  get "api/logs/:id" => "logs#show"
  post "api/logs" => "logs#create"
  get "api/places" => "places#index"
  get "api/matches" => "matches#index"
  get "api/matches/:id" => "matches#show"
  delete "api/matches/:id" => "matches#delete"
  post "api/matches" => "matches#create"
  get "api/places" => "places#index"
  get "api/opponents" => "opponents#index"
  get "api/opponents/:id" => "opponents#show"
  get "api/schools" => "schools#index"
  get "api/teams" => "teams#index"
  root to: "home#index"
  match "*path", to: "home#index", format: false, via: :get
end
