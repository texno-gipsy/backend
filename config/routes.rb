Rails.application.routes.draw do
  get 'hc' => 'application#hc'

  namespace :api do
    namespace :client do
      namespace :v1 do
        resources :users, only: %i[index show update]
        resources :events, only: %i[index update create show destroy]
        resources :participations, only: %i[create destroy]
      end
    end
  end
end
