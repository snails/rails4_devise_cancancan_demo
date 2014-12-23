Rails.application.routes.draw do
  resources :posts do
    resources :comments
  end

  root 'home#index'
  get 'home/about'
  get 'home/help'

  devise_for :users, path: 'accounts', skip: [:sessions, :registrations], controllers: { passwords: "users/passwords" }
  devise_scope :user do 
    resource :registeration, 
              as: 'user_registration',
              except: [:new, :destroy],
              path: 'accounts',
              controller: 'users/registrations'
  end
  as :user do
    get 'login' => 'users/sessions#new', :as => :new_user_session
    post 'login' => 'users/sessions#create', :as => :user_session
    delete 'logout' => 'users/sessions#destroy', :as => :destroy_user_session
    get 'register' => 'users/registrations#new', :as => :new_user_registeration
  end
end
