require 'sidekiq/web'
Liki::Application.routes.draw do
  root to: 'nodes#root'

  concern :position do
    put :up, on: :member
    put :down, on: :member
  end

  resources :nodes, concerns: :position, path: 'p' do
    get :admin, on: :member
  end

  resources :users, path: 'u'
  resources :members, path: 'm'
  resources :spaces
  resources :followings, path: 'f'

  get 'novedades' => 'nodes#index', as: :recent
  get 'buscar' => 'nodes#search', as: :search
  get 'mapa' => 'explorer#map', as: :map

  get 'entrar(/:id)' => 'sessions#new', as: :login
  get 'salir' => 'sessions#destroy', as: :logout
  get 'enter/:id', to: 'sessions#enter', as: :enter
  get 'user_level/:id', to: 'sessions#user_level'
  get 'visit/:id', to: 'sessions#visit', as: :visit
  post 'invitacion', to: 'sessions#send_token', as: :send_token
  mount Sidekiq::Web, at: '/sidekiq'
end
