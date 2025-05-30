Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"

  resources :items do
    resources :orders, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  end
end
