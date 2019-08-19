# frozen_string_literal: true

Rails.application.routes.draw do
  root "members#index"

  devise_for :admins, controllers: { sessions: "manager/sessions", passwords: "manager/passwords" }
  devise_for :members, controllers: { registrations: "registrations",
                                      sessions: "sessions", passwords: "passwords", confirmations: "confirmations" }

  get "favorite_spaces/:id", to: "home#show"
  get "autocomplete", to: "search#show"

  resources :favorite_spaces, only: [:show]
  resources :search, only: :index
  resources :autocomplete, only: :index

  namespace :manager do
    root "members#index"

    resources :rooms do
      resources :prices
    end

    resources :locations do
      resources :areas, except: %i[destroy edit update]
    end

    resources :areas, except: %i[new create] do
      resources :addresses, only: %i[new create]
    end

    resources :favorite_spaces
    resources :admins
    resources :members
    resources :utilities
    resources :areas, except: %i[new create]
  end
end
