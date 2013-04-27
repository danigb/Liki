Liki::Application.routes.draw do
  root to: 'nodes#index'

  resources :nodes, path: 'p'
end
