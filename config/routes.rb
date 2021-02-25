Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get 'users/sign_in', to: 'users/sessions#new', as: :new_user_session
  get 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
end
