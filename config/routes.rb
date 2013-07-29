Xob::Application.routes.draw do

  devise_for :users

  resources :searches, only: [:new, :create, :index]

  root :to => 'searches#new'

end
