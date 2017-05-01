require 'locker_room/constraints/subdomain_required'
require 'locker_room/engine'

Rails.application.routes.draw do
  constraints(LockerRoom::Constraints::SubdomainRequired) do
    scope module: :finance, as: :finance do
      resources :ledgers, path: 'finances', except: [:show] do
        # finance_ledgers
        get '/overview', action: :show, on: :member

        resource :budget, only: [:show, :edit, :update]

        resources :categories
        resources :accounts, except: :show do
          resources :transactions
          resources :journalizings, only: [:index],
            constraints: {type: /income|expense/, format: :json}
        end
      end
    end

    resources :snippets

    resources :contacts do
      get :search, on: :collection
    end

    get  '/countries/:code/divisions', to: 'countries#divisions',
      constraints: {code: /[A-Z]{2}/},
      defaults:    {format: :json}

    root to: 'finance/ledgers#index'
  end

  constraints(Constraints::WithoutSubdomain) do
    get '/', to: 'locker_room/sessions#new', as: :global_root
  end

  # NOTE: private beta
  constraints(LockerRoom::Constraints::SubdomainRequired) do
    match '/signup', to: proc { [404, {}, [":'("]] }, via: :all
  end

  constraints(Constraints::WithoutSubdomain) do
    match '/signup', to: proc { [404, {}, [":'("]] }, via: :all
  end

  mount LockerRoom::Engine, at: '/'
end
