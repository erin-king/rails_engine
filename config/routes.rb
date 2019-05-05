Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show', as: :find
        get '/find_all', to: 'search#index', as: :find_all
        get 'random', to: 'random#show', as: :random
        get '/most_revenue', to: 'most_revenue#index', as: :most_revenue
      end

      resources :merchants, only: [:index, :show] do
        get '/items', to: 'merchants/items#index', as: :items
        get '/invoices', to: 'merchants/invoices#index', as: :invoices
      end

      # namespace :customers do
      # end

      resources :customers, only: [:index, :show]



    end
  end
end
