# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

  get "favorite_spaces/:id", to: "home#show"
  get "autocomplete", to: "search#show"
  post "/like", to: "likes#create"
  delete "/unlike", to: "likes#destroy"
  get "/wishlist", to: "likes#wishlist"

  devise_for :admins, controllers: { sessions: "manager/sessions", passwords: "manager/passwords" }
  devise_for :members, controllers: { registrations: "registrations", sessions: "sessions",
                                      passwords: "passwords", confirmations: "confirmations" }
  get "/members/:member_id/rooms/:id/", to: "profiles#show", as: :show_profile
  get "/members/:id", to: "profiles#index", as: :index_profile

  resources :rooms do
    resources :prices
  end

  resources :favorite_spaces, only: [:show]
  resources :search, only: :index
  resources :autocomplete, only: :index
  resources :trends

  namespace :manager do
    root "members#index"

    resources :rooms do
      resources :prices
    end

    resources :locations do
      resources :areas, except: %i[destroy edit update]
    end

    resources :favorite_spaces
    resources :admins
    resources :members
    resources :utilities
    resources :areas, except: %i[new create]
  end
end
