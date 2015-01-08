Rails.application.routes.draw do
  
  resources :announcements, only: [:index, :show]
  resources :banners, only: [:index, :show]

  devise_for :admins
  
  root "statics#index"

  resources :pages, :controller => :statics, only: [:index, :show, :vehicles] do 
    collection do
      get "vehicles" => "statics#vehicles", :as => "vehicles"
      get ':page', :action => :show, :as => :page
    end
  end
  
  resources :vehicles, only: [:index, :show]
  
  resources :stations, only: [:index, :show] do 
    collection do 
      post 'search', action: 'search'
    end
  end

  get 'fetch_from_country' => 'stations#fetch_from_country'
  get 'fetch_from_city' => 'stations#fetch_from_city'

  resources :contacts, only: [:index, :create]
  # resources :reservations, only: [:index, :create]

  resources :FAQs, :controller => :boxes , :only => [ :index, :show] # resources :boxes, only: [:index, :show]
  
  resources :faqs, only: [:fetch_by_box] do
    collection do 
      match 'search' => 'faqs#search', via: [:post], as: :search  
    end
    member do
      get 'fetch_by_box', action: 'fetch_by_box'
    end
  end

  # Admin
  namespace :admin do

    authenticated :admin do
      root "announcements#index"#, :as => :authenticated_root
    end
    
    resources :admins

    resources :announcements do 
      member do
        post  'peditor/:id/createPhoto'       => 'peditor#createPhoto'
        post 'create_announcement_attachment' , :action => 'create_announcement_attachment'
        match :announcementphoto_upload, :via => :get

        get '/custom_edit' => 'announcements#custom_edit'
        patch '/custom_edit' => 'announcements#update'

      end
    end
    
    resources :index_sliders, controller: 'banners', type: 'IndexSlider'
    resources :selected_vehicles, controller: 'banners', type: 'SelectedVehicle'
    
    #BES Stations
    resources :stations do
      member do 
        get 'fetch_from_country' , action: 'fetch_from_country'
        get 'fetch_from_city' , action: 'fetch_from_city'

        post 'create_station_attachment' , :action => 'create_station_attachment'
        match :stationphoto_upload, :via => :get
      end 

      collection do 
        get 'fetch_from_country' , action: 'fetch_from_country'
        get 'fetch_from_city' , action: 'fetch_from_city'
      end
    end

    resources :categories do 
      resources :vehicles do

        get   '/sliders'       => 'vehicles#slider', as: 'slider'
        patch  '/upload_slider'       => 'vehicles#upload_slider'

        get   '/dms'       => 'vehicles#dm', as: 'dm'
        patch  '/upload_dm'       => 'vehicles#upload_dm'

        get   '/photos'       => 'vehicles#photo', as: 'photo'
        patch  '/upload_photo'       => 'vehicles#upload_photo'

        resources :specs
        resources :accessories
        resources :features
        resources :colors

      end

      member do
        patch 'reorder' , :action => 'reorder'
      end 

    end

    resources :vehicles do 
      member do
        patch 'reorder' , :action => 'reorder'
      end 
    end
    
    resources :contacts, only: [:index]
    
    resources :boxes do 
      resources :faqs do 
        member do 
          post  'peditor/:id/createPhoto'       => 'peditor#createPhoto'
        end
      end 
    end

    resources :galleries do 
      member do
        patch 'multiple_reorder' , :action => 'multiple_reorder'
      end 
    end

    resources :contacts, :only => [:index, :update] do
      collection do 
        get 'history', action: 'history'
      end
    end
    
    resources :reservations, :only => [:index, :update] do
      collection do 
        get 'history', action: 'history'
      end
    end
    
  end

  get '(*url)'   => 'errors#index'

end
