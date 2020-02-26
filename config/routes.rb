Rails.application.routes.draw do
  devise_for :users
  root "users#index"
  get 'users/talkindex', to: 'users#talkindex'
  resources :users, only: [:index, :edit, :update, :show] do
    member do
      put 'users/follow/:user_id', to: 'users#follow'
      put 'users/unfollow/:user_id', to: 'users#unfollow'
    end
    collection do
      get 'search'
      get 'search_result'
    end
  end

  resources :groups, only: [:new, :create, :edit, :update, :destroy, :show] do
    resources :groupmessages, only: [:index, :create]
    namespace :api do
      resources :groupmessages, only: :index, defaults: { format: 'json' }
    end
  end

  resources :friends, only: [:create] do
    resources :directmessages, only: [:index, :create]
    namespace :api do
      resources :directmessages, only: :index, defaults: { format: 'json' }
    end
  end

end
