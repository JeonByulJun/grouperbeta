Rails.application.routes.draw do
  resources :resumes, only: [:index, :new, :create, :destroy]

  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'team#index'
  get '/team/newteam' => 'team#newteam'
  get '/team/addmember' => 'team#addmember'
  post '/team/adding' => 'team#adding'
  get '/team/adding' => 'team#adding'
  get '/chat/show' => 'chat#show'
  post '/chat/create' => 'chat#create'
  get '/message/show' => 'message#show'
  post '/message/create' => 'message#create'
  post '/task/create' => 'task#create'
  get '/task/show' => 'task#show'
  get '/task/entire' => 'task#entire'
  post '/team/create' => 'team#create'
  post '/task/wansungdo_update' => 'task#wansungdo_update'
  post '/test/index' => 'test#index'
  get '/team/profile' => 'team#profile'
  post '/team/profileupdate' => 'team#profileupdate'
  post '/team/change_etc1' => 'team#change_etc1'
  post '/team/change_etc2' => 'team#change_etc2'
  get '/test/index' => 'test#index'
  get '/test/invitation' => 'test#invitation'
  put '/whiteboard/update' => 'whiteboard#update'
  post '/whiteboard/update2' => 'whiteboard#update2'
  put '/message/update' => 'message#update'
  post '/imageup' => 'message#imageup'
  post '/fileup' => 'message#fileup'
  post '/team/deletemember' => 'team#deletemember'
  post '/chat/deletemember' => 'chat#deletemember'
  put '/message/updateall' => 'message#updateall'
  post '/test/regmail' => 'test#regmail'
  get '/test/regmail' => 'team#index'
  get '/team/noteam' => 'team#noteam'
  get '/team/search' => 'team#search'
  post '/chat/addmember' => 'chat#addmember'
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
