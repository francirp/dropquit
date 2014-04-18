Dropquit::Application.routes.draw do

  root to: 'pages#home'
  resources :posts
  resources :quits
  devise_for :users, :controllers => {:registrations => "registrations"}

end
