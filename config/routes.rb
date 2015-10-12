Rails.application.routes.draw do

  resources :mtx_products
  get 'weekly_menu/manage(/:dayOfWeek)' => 'weekly_menu#manage', as: :weekly_menu_manage, :defaults => {:dayOfWeek => "mon"}
  post 'weekly_menu/manage' => 'weekly_menu#update', as: :update_weekly_menu

  EasilyOrderFood::Application.routes.draw do
    scope "(:locale)", :locale => /en|de/ do
      root :to => 'home#index'
      get "home/index"
    end
  end
  # root 'home#index'

  # Routes for mtx_order
  #get 'mtx_order' => 'mtx_order#show_list'
  get 'mtx_order/show_list' => 'mtx_order#show_list'
  resources :mtx_order

  # Routes for mtx_user
  get 'mtx_user/show_list' => 'mtx_user#show_list'
  resources :mtx_user

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'home#index'

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
