Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :foods, path: '/foods', only: [:index, :create, :update] do
    # collection do
    #
    # end
    # member do
    #
    # end
  end
end
