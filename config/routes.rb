Rails.application.routes.draw do
  root to: "home#index"
  match "*path", to: "home#index", format: false, via: :get
end
