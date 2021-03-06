require 'sidekiq/web'
Liki::Application.routes.draw do

  root to: 'nodes#root'

  concern :position do
    put :up, on: :member
    put :down, on: :member
  end

  resources :nodes, concerns: :position, path: 'p' do
    get :admin, on: :member
    post :admin, on: :member
    resources :nodes, path: 'p', only: :new
    resources :followings, path: 'f', only: :index
    resource :document, path: 'doc'
    resource :task, path: 'tarea'
    resource :event, path: 'evento', only: [:show, :new]
    resources :comments, path: 'comentarios'
  end

  resources :users, path: 'u'
  resources :members, path: 'm'
  resources :spaces
  resources :activities, path: 'a'
  resources :access
  resources :followings, path: 'f', only: [:create, :destroy]
  resources :photos, path: 'fotos'
  resources :photo_tags, path: 'ptag'
  resources :prototypes, path: 'tipos'

  get '/calendario(/:y(/:m))' => 'events#index', as: :calendar,
    constraints: {y: /\d{4}/, m: /\d{1,2}/}
  resources :events, path: 'calendario', except: [:index]
  get 'mapa' => 'explorer#map', as: :map


  resource :inbox, controller: 'inbox', only: [:show,:create]

  get 'novedades' => 'nodes#index', as: :recent
  get 'buscar' => 'explorer#search', as: :search

  resources :sessions, path: 's'
  get 'entrar(/:id)' => 'sessions#new', as: :login
  get 'salir' => 'sessions#destroy', as: :logout
  get 'enter/:id', to: 'sessions#enter', as: :enter
  get 'user_level/:id', to: 'sessions#user_level'
  get 'visit/:id', to: 'sessions#visit', as: :visit
  post 'invitacion', to: 'sessions#send_token', as: :send_token

  mount Sidekiq::Web, at: '/sidekiq'

  get '404' => 'site#error404'
  get '500' => 'site#error500'
  get 'mmmm', to: 'site#access_denied', as: :access_denied
end
