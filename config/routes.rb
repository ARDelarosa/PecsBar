Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations]

  root "home#index"

  resources :events, only: [
    :index, :show, :new, :create, :edit, :update, :destroy
  ]

  namespace :management, path: "admin" do
    root "dashboard#index"
    resources :events, only: [:index]
  end
end
