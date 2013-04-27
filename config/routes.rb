Liki::Application.routes.draw do
  root to: 'nodes#index'

  resources :nodes, path: 'p' do
    post :add_children, on: :member
  end
  resources :users
  resources :sessions
  get 'enter/:id', to: 'sessions#enter'
end
