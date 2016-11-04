Rails.application.routes.draw do

  get 'landing/index'

    get 'app/index'

    root to: 'home#index'

    get 'auth/:provider/callback', to: 'sessions#create'
    get 'auth/failure', to: redirect('/')
    get 'signout', to: 'sessions#destroy', as: 'signout'
    post '/login' => 'sessions#create'

    post '/events/:event_id/attending/:user_id', to: 'events#attending', as: :attending
    post '/events/:event_id/cancel_rsvp/:user_id', to: 'events#cancel_rsvp', as: :cancel_rsvp
    get '/events/top', to: 'events#top', as: :top_events

    get '/users/:user_id/venues', to: 'venues#user_venues', as: :user_venues

    resources :users, only: [:new, :create]
    resources :sessions, only: [:new, :create, :destroy]
    resources :games, only: [:index, :show]
    resources :search, only:[:index]
    resources :reviews, only:[:delete]
    resources :events, only: [:index, :show, :create]

    resources :venues, only: [:new, :create, :show, :destroy] do
      resources :reviews, only: [:create]
    end

    get 'map', to: 'venues#index', as: :map;

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
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
