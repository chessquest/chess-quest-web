Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get '/:game_id/', to: 'gameplay#show', as: :gameplay
  namespace :users do
    get '/:id/dashboard', to: 'dashboard#show', as: 'dashboard'
    post '/:id/quests', to: 'quests#create', as: 'new_quest'
    post '/:id/games', to: 'games#create', as: 'new_game'
  end
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  devise_scope :user do
    get 'users/sign_in', to: 'users/sessions#new', as: :new_user_session
    get 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
  end
end
