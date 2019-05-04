Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        # get 'merchants/most_revenue', to: 'merchants#index'
        get '/items', to: 'merchants/items#index', as: :items
        get '/invoices', to: 'merchants/invoices#index', as: :invoices
      end
    end
  end
end

# GET /api/v1/merchants/:id/items returns a collection of items associated with that merchant
#
# GET /api/v1/merchants/:id/invoices returns a collection of invoices associated with that merchant from their known orders
# get 'merchants/find', to: 'search#show' MINE
# resources :merchants, only: [:index, :show] do
#   get '/items', to: 'merchants/items#index', as: :items
#   get '/invoices', to: 'merchants/invoices#index', as: :invoices
#   get '/revenue', to: 'merchants/revenue#show', as: :revenue
#   get '/favorite_customer', to: 'merchants/customers#show', as: :favorite_customer
#   get '/customers_with_pending_invoices', to: 'merchants/customers#index', as: :pending_customers


# namespace :merchants do
#   get '/find', to: 'search#show', as: :find
#   get '/find_all', to: 'search#index', as: :find_all
#   get '/revenue', to: 'revenue#index', as: :revenue
#   get '/most_revenue', to: 'most_revenue#index', as: :most_revenue
#   get '/most_items', to: 'most_items#index', as: :most_items
#   get '/random', to: 'random#show', as: :random
# end
#

# GET /api/v1/merchants/most_revenue?quantity=x
