Lefranc::Application.routes.draw do
 
  # Main / global 
  root :to => "home#index"
  
  # Home 
  get "home/index"

  # Users
  resources :users

  # User groups 
  match '/users/:user_id/groups(.:format)' => 'user_groups#index', :as => :user_groups, :via => :get

  # User lessons
  match '/users/:user_id/lessons(.:format)' => 'user_lessons#index', :as => :user_lessons, :via => :get

  # Groups
  resources :groups

  # Group users
  match '/groups/:group_id/users(.:format)' => 'group_users#index', :as => :group_users, :via => :get
  match '/groups/:group_id/users/:id(.:format)' => 'group_users#create', :as => :create_group_user, :via => :post
  match '/groups/:group_id/users/:id(.:format)' => 'group_users#destroy', :as => :delete_group_user, :via => :delete

  # Lessons
  resources :lessons

  get "word_gender/index"

  resources :languages do
    resources :word_genders
  end

  resources :translations
	

  # Authentication via providers	
  get "sessions/index"
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
	
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
