Rails.application.routes.draw do
  get "api/matches" => "matches#index"
  get "api/places" => "places#index"
  get "api/opponents" => "opponents#index"
  get "api/opponents/:id" => "opponents#show"
  get "api/schools" => "schools#index"
  get "api/teams" => "teams#index"
  root to: "home#index"
  match "*path", to: "home#index", format: false, via: :get
end
