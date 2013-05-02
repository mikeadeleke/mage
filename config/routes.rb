Mage::Application.routes.draw do
  get "/" => "Pages#home", :as => "home"
  get "/search" => "Pages#search", :as => "search"

  # Session
  # ---------------------------------------------
  
  get "/sign-in" => 'Sessions#new', :as => "sign_in"
  delete "/sign-out" => 'Sessions#destroy', :as => "sign_out"
  post "/sign-in" => "Sessions#create", :as => "sessions"

  # User
  # ---------------------------------------------

  # CREATE

  get "/register" => "Users#new", :as => "new_user"
  post "/register" => "Users#create", :as => "users"

  # READ

  # get "/users" => "Users#index"
  get "/users/:user_name" => "Users#show", :as => "user"

  # UPDATE

  get "/users/:user_name/edit" => "Users#edit", :as => "edit_user"
  put "/users/:user_name" => "Users#update", :as => "user"

  # DELETE

  delete "/users/:user_name" => "Users#destroy", :as => "user"

  # Resource
  # ---------------------------------------------

  # CREATE

  get "/resources/new" => "Resources#new", :as => "new_resource"
  post "/" => "Resources#create", :as => "resources"


  # READ

  get "/:classification_path/:craft_path/:resource_path" => "Resources#show", :as => "resource"

  # UPDATE

  # DELETE

  # SEARCH

  # Craft
  # ---------------------------------------------

  get "/:classification_path/:craft_path" => "Crafts#show", :as => "craft"


  # Classification
  # ---------------------------------------------

  # READ

  get "/:classification_path" => "Classifications#show", :as => "classification"




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
