Rails.application.routes.draw do
  get 'static/:id/show' => 'static#show', as: :static

  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'labs#index'

  resources :labs
  resources :users
  resources :assignments

  get 'assignments/:id/grades' => 'assignments#grades', as: :assignments_grades
  get 'labs/:id/grades' => 'labs#grades', as: :labs_grades
  post 'labs/:id/toggle_hidden' => 'labs#toggle_hidden', as: :labs_toggle_hidden


  # For the button_to call to test code
  post 'assignments/testCode'
  post 'assignments/saveCode'
  post 'assignments/restartCode'
  post 'assignments/uploadCode'
  post 'assignments/downloadCode'
  post 'assignments/submitCode'
  post 'assignments/revertCodeToSaved'

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
