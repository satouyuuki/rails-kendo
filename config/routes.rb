Rails.application.routes.draw do
  get "api/teams" => "teams#index"
  root to: "home#index"
  match "*path", to: "home#index", format: false, via: :get
end
