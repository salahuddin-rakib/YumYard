Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # resources :resources, path: '/resources', only: [:index, :create, :update] do
  #   collection do
  #
  #   end
  #   member do
  #
  #   end
  # end

  resources :foods, path: '/foods', only: [:index, :create, :update]
  resources :coupons, path: '/coupons', only: [:create, :destroy]
  resources :orders, path: 'api/', only: [] do
    collection do
      post ':food_id/process_order', to: 'orders#process_order'
    end
  end
end
