# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pictures#index'
  resources :pictures do
    member do
      put :reject
      put :approve
    end
  end
  get '/pending', to: 'pictures#pending'
end
