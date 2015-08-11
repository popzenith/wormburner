WormBurner::Application.routes.draw do
  
	#########################################
  # If you are logged in or not logged in you still go to the home page, but you could go to different places
  #########################################
  root :to => "home#index"


  #########################################
  # the routes for user stuff etc are somewhere else because we are using devise
  # although this line overrides the registrations because we wanted to customize
  #########################################
  devise_for :users, :controllers => { :registrations => "registrations" }
  

  #########################################
  # the users
  #########################################
  resources :users, only: [:index, :create, :show, :update]  do
    member do
      get :search, :valid, :refreshnotify, :events, :eventsinprogress, :rounds
    end
    member do
      post :posteremail
    end
  end

  #########################################
  # other models
  #########################################
  resources :tokens, only: [:create, :destroy]

  resources :events, only: [:index, :create, :show, :update, :destroy]  do
    member do
      get :rounds, :users
    end
    member do
      post :adduser, :createround
    end
  end
  resources :rounds, only: [:index, :create, :show, :update]  do
    member do
      get :holes
    end
    member do
      post :createhole
    end
  end
  resources :holes, only: [:index, :create, :show, :update]

  resources :facilities, only: [:index, :create, :show, :update]  do 
    collection do
      get :search
    end
  end
  resources :courses, only: [:index, :create, :show, :update]
  resources :scorecards, only: [:index, :create, :show, :update] 
  resources :reservations, only: [:index, :create, :show, :update]

  resources :promos, only: [:index, :create, :show, :update]


  #########################################
  # email forms
  #########################################
  match 'contact' => 'contact#new', :as => 'contact', :via => :get
  match 'contact' => 'contact#create', :as => 'contactsend', :via => :post

  #########################################
  # tee times
  #########################################
  match 'teetimes' => 'bookteetimes#new', :as => 'teetimes', :via => :get
  match 'bookteetimes' => 'bookteetimes#newfull', :as => 'bookteetimes', :via => :get

  #########################################
  # poster
  #########################################
  match 'rorymcilroy' => 'rorymcilroy#new', :as => 'rorymcilroy', :via => :get

  #########################################
  # match defines a url directly 
  # these are the static pages
  #########################################
  match 'list/subscribe' => 'static_pages#subscribe', :as => 'subscribe', :via => :get
  match 'list/unsubscribe' => 'static_pages#unsubscribe', :as => 'unsubscribe', :via => :get
  match 'list/confirmed' => 'static_pages#confirmed', :as => 'confirmed', :via => :get

end
