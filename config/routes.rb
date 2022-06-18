Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users, only: [:index, :show, :create, :update, :destroy] do
    collection do
      put 'increase_credit' => 'users#increase_credit'
      put 'give_note' => 'users#give_note'
    end

    resources :donations, only: [:index, :show, :create, :update, :destroy] do
      collection do
        get 'donation_infos' => 'donations#donation_infos'
        put 'complete_donation' => 'donations#complete_donation'
        delete 'cancel_donation' => 'donations#cancel_donation'
      end
    end

    resources :books, only: [:index, :show, :create, :update, :destroy] do
      collection do
        put 'register_interest' => 'books#register_interest'
        put 'register_donation' => 'books#register_donation'
      end
    end
  end
  resources :cities, only: [:index, :show, :destroy]
  resources :states, only: [:index, :show, :destroy]
  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
