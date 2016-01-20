Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resources :restaurants do
    resources :reviews
  end

  root to: "restaurants#index"

end
