Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:show, :index, :update, :create]
      resources :days, only: [:show, :index, :create, :update]
      post "/session-days", to: "sessions#days"
    end
  end

end
