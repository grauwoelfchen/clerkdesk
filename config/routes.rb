require "locker_room/constraints/subdomain_required"
require "locker_room/engine"

Rails.application.routes.draw do
  constraints(LockerRoom::Constraints::SubdomainRequired) do
    resources :notes

    resources :finances do
      resource :budget,     only: [:show, :edit, :update]
      resource :settlement, only: [:show, :edit, :update]
      resource :ledger
      resources :categories, controller: :finance_categories
      resources :entries,    controller: :ledger_entries, as: :ledger_entries
    end

    post :locale, to: "locale#switch", as: :switch_locale

    root to: "desktop#index"
  end
  mount LockerRoom::Engine, at: "/"
end
