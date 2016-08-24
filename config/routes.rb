Rails.application.routes.draw do

  mount Blacklight::Engine => '/'
  root to: "catalog#index"
    concern :searchable, Blacklight::Routes::Searchable.new

  resource :catalog, only: [:index], as: 'catalog', path: '/catalog', controller: 'catalog' do
    concerns :searchable
  end

  concern :exportable, Blacklight::Routes::Exportable.new

  resources :solr_documents, only: [:show], path: '/catalog', controller: 'catalog' do
    concerns :exportable
  end

  resources :bookmarks do
    concerns :exportable

    collection do
      delete 'clear'
    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }, format: false
  devise_scope :user do
    match '/users/sign_in', :to => "users/sessions#new", :as => :new_user_session, via: [:get]
    match '/users/sign_out', :to => "users/sessions#destroy", :as => :destroy_user_session, via: [:get]
  end

  resources :media_objects, except: [:create, :update] do
    member do
      put :update, action: :update, defaults: { format: 'html' }, constraints: { format: 'html' }
      put :update, action: :json_update, constraints: { format: 'json' }
      patch :update, action: :update, defaults: { format: 'html' }, constraints: { format: 'html' }
      put :update_status
      get :progress, :action => :show_progress
      get 'content/:datastream', :action => :deliver_content, :as => :inspect
      get 'track/:part', :action => :show, :as => :indexed_section
      get 'section/:content', :action => :show, :as => :id_section
      get 'tree', :action => :tree, :as => :tree
      get :confirm_remove
    end
    collection do
      post :create, action: :create, constraints: { format: 'json' }
      get :confirm_remove
      put :update_status
      # 'delete' has special signifigance so use 'remove' for now
      delete :remove, :action => :destroy
    end
  end
  resources :master_files, except: [:new, :index, :update] do
    member do
      get  'thumbnail', :to => 'master_files#get_frame', :defaults => { :type => 'thumbnail' }
      get  'poster',    :to => 'master_files#get_frame', :defaults => { :type => 'poster' }

      post 'thumbnail', :to => 'master_files#set_frame', :defaults => { :type => 'thumbnail', :format => 'html' }
      post 'poster',    :to => 'master_files#set_frame', :defaults => { :type => 'poster', :format => 'html' }
      post 'still',     :to => 'master_files#set_frame', :defaults => { :format => 'html' }
      get :embed
      post 'attach_structure'
      post 'attach_captions'
      get :captions
    end
  end
  resources :derivatives, only: [:create]

  namespace :admin do
    resources :groups, except: [:show] do
      collection do
        put 'update_multiple'
      end
      member do
        put 'update_users'
      end
    end
    resources :collections do
      member do
        get 'edit'
        get 'remove'
        get 'items'
      end
    end
  end

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
