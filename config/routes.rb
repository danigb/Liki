Liki::Application.routes.draw do
  root to: 'nodes#index'

  resources :nodes, path: 'p' do
    post :add_children, on: :member
  end
end
