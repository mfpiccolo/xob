Xob::Application.routes.draw do

  devise_for :users

  resources :searches, only: [:new, :create, :index] do
    collection do
      post :save_search
    end
  end

  root :to => 'searches#new'

end
