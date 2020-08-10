Rails.application.routes.draw do
  root 'match_lists#show'
  get 'match_lists/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
