require 'locker_room/constraints/subdomain_required'
require 'locker_room/engine'

Rails.application.routes.draw do
  constraints(LockerRoom::Constraints::SubdomainRequired) do
    resources :notes
    resources :users, only: [:index, :show]
    resources :contacts do
      get :search, on: :collection
    end

    scope module: :finance, as: :finance do
      resources :ledgers, path: 'finances', except: [:show] do
        # finance_ledgers
        get '/overview', action: :show, on: :member

        resource :budget, only: [:show, :edit, :update]

        resources :categories
        resources :accounts do
          resources :entries
          resources :journalizings, only: [:index],
            constraints: {type: /income|expense/, format: :json}
        end
      end
    end

    post '/locale', to: 'locales#switch', as: :switch_locale

    get  '/countries/:code/divisions', to: 'countries#divisions',
      constraints: {code: /[A-Z]{2}/},
      defaults:    {format: :json}

    root to: 'desktop#index'
  end

  constraints(Constraints::WithoutSubdomain) do
    get '/', to: 'locker_room/entrance#index', as: :global_root
  end

  mount LockerRoom::Engine, at: '/'
end
