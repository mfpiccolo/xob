Xob::Application.routes.draw do

  devise_for :users

  resources :searches, only: [:new, :create] do
    collection do
      post :save_search
      get :get_draggables
    end
  end

  root :to => 'searches#new'

end
