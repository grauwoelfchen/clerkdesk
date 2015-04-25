require "locker_room/engine"
require "locker_room/constraints/subdomain_required"

Rails.application.routes.draw do
  get 'notes/index'

  constraints(LockerRoom::Constraints::SubdomainRequired) do
    resources :notes, only: [:index, :show]
    root to: "pages#index"
  end
  mount LockerRoom::Engine, at: "/"
end
