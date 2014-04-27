Dropquit::Application.routes.draw do

  root to: 'pages#home'
  resources :posts
  resources :comments
  resources :checkpoints, controller: 'posts', type: 'Checkpoint'
  resources :introductions, controller: 'posts', type: 'Introduction'
  resources :quits
  devise_for :users, :controllers => {:registrations => "registrations"}

end
