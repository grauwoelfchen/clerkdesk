require "locker_room/engine"
require "locker_room/constraints/subdomain_required"

Rails.application.routes.draw do
  get 'settlements/show'

  constraints(LockerRoom::Constraints::SubdomainRequired) do
    resources :notes

    resources :accounts do
      resource :budget,     only: [:show, :edit, :update]
      resource :settlement, only: [:show, :edit, :update]
      scope shallow_path: "account", shallow_prefix: "account" do
        resources :ledgers, shallow: true, path: "books"
      end
    end

    root to: "desktop#index"
  end

  mount LockerRoom::Engine, at: "/"
end
