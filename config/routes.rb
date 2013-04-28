Liki::Application.routes.draw do
  root to: 'groups#show'

  concern :position do
    put :up, on: :member
    put :down, on: :member
  end

  resources :nodes, concerns: :position, path: 'p' do
    post :add_children, on: :member
  end
  resources :users, path: 'u'

  get 'entrar(/:id)' => 'sessions#new', as: :login
  get 'salir' => 'sessions#destroy', as: :logout
  get 'enter/:id', to: 'sessions#enter'
  get 'visit/:id', to: 'sessions#visit'
end
