Rails.application.routes.draw do

  resources :messages

  get 'messages/:id/reply' => 'messages#reply', as: :reply_message

  resources :conditions
  resources :categories

  resources :schools do
    resources :items
  end

  devise_for :users
  scope "/admin" do
    resources :users
  end
  resources :items

  resources :roles

  resources :user_friends
  resources :favorites


  authenticated :user do
    # root to: "items#index", as: :authenticated_root
    root to: 'welcome#home', as: :authenticated_root
  end
  root :to => 'welcome#index'

  get 'my_items' => 'items#my_items', as: :my_items
  post 'add_fav/:school_id' => 'users#add_fav', as: :add_fav

  get 'help' => 'welcome#help'
  get 'whats_new' => 'welcome#whats_new'
  get 'friends' => 'users#friends'
  get 'invite' => 'users#invite'
  post 'invite' => 'users#send_invitations'

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
