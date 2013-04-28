Liki::Application.routes.draw do
  root to: 'nodes#index'

  concern :position do
    put :up, on: :member
    put :down, on: :member
  end

  resources :nodes, concerns: :position, path: 'p' do
    post :add_children, on: :member
  end
  resources :users, path: 'u'
  resources :sessions, path: 'sesion'
  get 'enter/:id', to: 'sessions#enter'
end
