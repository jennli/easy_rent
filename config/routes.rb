Rails.application.routes.draw do

  resources :listings do
    resources :reservations, only: [:index, :show, :create, :destroy, :edit, :update]
  end

  post "/listing/:listing_id/reservations/:id" => "reservations#cancel", as: "cancel_reservation_path"



  devise_for :users, controllers: { registrations: 'devise_registrations',  omniauth_callbacks: "users/omniauth_callbacks" }
  get '/orders/subregion_options' => 'listings#subregion_options'

  get "/listings/:id/reserved_dates" => "listings#reserved_dates", as: "listing_reserved_dates_path"

  resources :search_listings, only:[:show]

  resources :reservations, only: [] do
    resources :payments, only: [:new, :create]
  end
  resources :users
  resources :my_reservations, only: [:index]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'listings#index'
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
