Xob::Application.routes.draw do

  resources :searches, only: [:new, :create, :index]

  root :to => 'searches#new'

end
