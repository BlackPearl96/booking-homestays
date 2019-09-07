# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

  devise_for :admins, controllers: { sessions: "manager/sessions", passwords: "manager/passwords" }
  devise_for :members, controllers: { registrations: "registrations",
                                      sessions: "sessions", passwords: "passwords", confirmations: "confirmations" }

  devise_scope :member do
    get "/members/:member_id/rooms/:id/", to: "registrations#show", as: "show_profile"
    get "members/:id", to: "registrations#index", as: "index_profile"
  end

  resources :rooms do
    resources :prices
  end

  namespace :manager do
    root "members#index"

    resources :rooms do
      resources :prices
    end

    resources :favorite_spaces
    resources :admins
    resources :members
    resources :utilities

    resources :locations do
      resources :areas, except: %i[destroy edit update]
    end

    resources :areas, except: %i[new create] do
      resources :addresses, only: %i[new create]
    end

    resources :areas, except: %i[new create]
    resources :prices, only: %i[index new create]
  end
end
