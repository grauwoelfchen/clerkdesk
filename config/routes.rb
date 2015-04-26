require "locker_room/engine"
require "locker_room/constraints/subdomain_required"

Rails.application.routes.draw do
  constraints(LockerRoom::Constraints::SubdomainRequired) do
    resources :notes
    root to: "desktop#index"
  end

  mount LockerRoom::Engine, at: "/"
end
