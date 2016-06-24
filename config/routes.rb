Rails.application.routes.draw do

  #base index page
  root 'welcome#index'

  #independent projects
  get 'factorio', to: 'welcome#factorio'
  get 'initium+', to: 'welcome#initium+'
  get 'thaiLinPan', to: 'welcome#thaiLinPan'
  get 'volunDev', to: 'welcome#volunDev'

  #fcc frontend weatherApp
  get 'weather', to: 'welcome#weather'

  #fcc frontend portfolio
  get 'portfolio', to: 'welcome#portfolio'

  #fcc backend timestamp microservice
  get 'timestamp', to: 'welcome#timestamp'
  get 'timestamp/:time', to: 'welcome#create'

  #fcc backend getHeader
  get 'whoami', to: 'welcome#getHeader'

  #fcc backend url shortener microservice
  # =>create new shortened link
  get 'newShLink/*original(.:format)', to: 'shorturl#create'
  # =>forward from shortened link to reference
  get 'l/:ident', to: 'shorturl#forward'

  #fcc backend image search abstraction layer
  get 'imageSearch', to: 'search#main'
  get 'imageSearch/:query?offset=:offset', to: 'search#offset'
  get 'imageSearch/*query', to: 'search#create'
  
  #fcc backend file size shower
  # =>submit a file form view
  #get 'filesize', to: 'filesize#create'
  # =>show filesize of submitted file
  #get 'filesize/show', to: 'filesize#show'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #   root 'welcome#index'
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
