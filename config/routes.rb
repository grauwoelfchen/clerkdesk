require "locker_room/engine"
require "locker_room/constraints/subdomain_required"

Rails.application.routes.draw do
  constraints(LockerRoom::Constraints::SubdomainRequired) do
    resources :notes

    resources :finances do
      resource :budget,     only: [:show, :edit, :update]
      resource :settlement, only: [:show, :edit, :update]
      resource :ledger
    end

    root to: "desktop#index"
  end

  mount LockerRoom::Engine, at: "/"
end
