require "locker_room/engine"
require "locker_room/constraints/subdomain_required"

Rails.application.routes.draw do
  get 'budgets/index'

  constraints(LockerRoom::Constraints::SubdomainRequired) do
    resources :notes
    resources :budgets
    root to: "desktop#index"
  end

  mount LockerRoom::Engine, at: "/"
end
