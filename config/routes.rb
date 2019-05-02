Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        get 'merchants/find', to: 'search#show'
        resources :items, only: [:index]
        resources :invoices, only: [:index]
      end
    end
  end

end
