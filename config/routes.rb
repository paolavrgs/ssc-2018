Rails.application.routes.draw do
  localized do
    get '/contact', to: 'app/front#contact', as: :app_contact
    get '/thanks/:id', to: 'app/front#thanks', as: :app_thanks
    get '/censo', to: 'app/front#censo', as: :app_censo
    get '/censoexitoso/:id', to: 'app/front#censoexitoso', as: :app_censoexito
    get '/about', to: 'app/front#about', as: :app_about
  end

  root to: 'app/front#index'

  devise_for :users, skip: KepplerConfiguration.skip_module_devise

  namespace :admin do
    root to: 'admin#root'
 
    resources :banners do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      post '/import', action: 'import', as: :import
    
      get '/download', action: 'download', as: :download
      post(
        '/sort',
        action: :sort,
        on: :collection,
      )
      get(
        '/reload',
        action: :reload,
        on: :collection,
      )
      delete(
        '/destroy_multiple',
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end
 
    resources :census do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      post '/import', action: 'import', as: :import
    
      get '/download', action: 'download', as: :download
      post(
        '/sort',
        action: :sort,
        on: :collection,
      )
      get(
        '/reload',
        action: :reload,
        on: :collection,
      )
      delete(
        '/destroy_multiple',
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :messages do
      get '(page/:page)', action: :index, on: :collection, as: ''
      post '/import', action: 'import', as: :import

      get '/download', action: 'download', as: :download
      post(
        '/sort',
        action: :sort,
        on: :collection,
      )
      get(
        '/reload',
        action: :reload,
        on: :collection,
      )
      delete(
        '/destroy_multiple',
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :downloads do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      post '/import', action: 'import', as: :import

      get '/download', action: 'download', as: :download
      post(
        '/sort',
        action: :sort,
        on: :collection,
      )
      get(
        '/reload',
        action: :reload,
        on: :collection,
      )
      delete(
        '/destroy_multiple',
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :customizes do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      post '/import', action: 'import', as: 'import'
      post '/install_default', action: 'install_default'
      # delete(
      #   action: :destroy_multiple,
      #   on: :collection,
      #   as: :destroy_multiple
      # )
    end

    resources :users do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/delete_avatar', action: :delete_avatar
      get(
        '/reload',
        action: :reload,
        on: :collection
      )
      delete(
        '/destroy_multiple',
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    post '/sorting', to: 'meta_tags#sort', as: :sorting_meta_tags
    resources :meta_tags do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      post '/import', action: 'import', as: 'import'
      get '/download', action: 'download', as: 'download'
      get(
        '/reload',
        action: :reload,
        on: :collection
      )
      delete(
        '/destroy_multiple',
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :scripts do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      post '/import', action: 'import', as: 'import'
      get '/download', action: 'download', as: 'download'
      get(
        '/reload',
        action: :reload,
        on: :collection
      )
      delete(
        '/destroy_multiple',
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
    end

    resources :settings, only: [] do
      collection do
        get '/:config', to: 'settings#edit', as: ''
        put '/:config', to: 'settings#update', as: 'update'
        put '/:config/appearance_default', to: 'settings#appearance_default', as: 'appearance_default'
      end
    end
  end

  # Errors routes
  match '/403', to: 'errors#not_authorized', via: :all, as: :not_authorized
  match '/404', to: 'errors#not_found', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  # Dashboard route engine
  mount KepplerGaDashboard::Engine, at: 'admin/dashboard', as: 'dashboard'

end
