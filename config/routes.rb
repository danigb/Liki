Liki::Application.routes.draw do
  root to: 'groups#show'

  concern :position do
    put :up, on: :member
    put :down, on: :member
  end

  resources :nodes, concerns: :position, path: 'p'
  resources :users, path: 'u'
  resources :members, path: 'm'
  resources :groups, path: 'g'

  get 'novedades' => 'nodes#index', as: :recent
  get 'buscar' => 'nodes#search', as: :search
  get 'mapa' => 'nodes#map', as: :map

  get 'entrar(/:id)' => 'sessions#new', as: :login
  get 'salir' => 'sessions#destroy', as: :logout
  get 'enter/:id', to: 'sessions#enter', as: :enter
  get 'visit/:id', to: 'sessions#visit', as: :visit
  post 'invitacion', to: 'sessions#send_token', as: :send_token
end
