require "locker_room/constraints/subdomain_required"
require "locker_room/engine"

Rails.application.routes.draw do
  constraints(LockerRoom::Constraints::SubdomainRequired) do
    resources :notes
    resources :users, only: [:index, :show]
    resources :people

    finance_resources = proc do
      resource :budget, only: [:show, :edit, :update]
      resource :ledger
      resources :categories, controller: :finance_categories
      resources :entries,    controller: :ledger_entries, as: :ledger_entries

      resources :journalizings, only: [:index],
        constraints: {type: /income|expense/, format: :json}
    end
    resources :finances,
      &finance_resources
    resource :finance,
      except: [:new, :create],
      as:     :primary_finance,
      &finance_resources

    post "/locale", to: "locales#switch", as: :switch_locale

    get  "/countries/:code/divisions", to: "countries#divisions",
      constraints: {code: /[A-Z]{2}/},
      defaults:    {format: :json}

    root to: "desktop#index"
  end
  mount LockerRoom::Engine, at: "/"
end
