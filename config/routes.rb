Golfpals::Application.routes.draw do
  
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
    # added GETs for all these to customize data we get about a user
    member do
      get :following, :following_count, :followers, :followers_count, :recentfollowers, :friendrequests, :friends, :myrelationship, :myreverserelationship, :venues, :microposts, :feed, :valid, :search
    end
    member do
      post :searchemail, :invitationemailonly, :refreshnotify, :blockuser
    end
  end

  #########################################
  # user related models
  #########################################
  resources :microposts, only: [:create, :destroy] do
    member do
      post :taguser
    end
  end
  resources :tokens,:only => [:create, :destroy]
  resources :relationships, only: [:create, :destroy] do
    member do
      post :updatestatus, :confirmfollow
    end
  end

  #########################################
  # the venues
  #########################################
  resources :venues, only: [:index, :create] do 
    member do
      post :favorite, :unfavorite
      get :feed
    end
  end

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
  # match defines a url directly 
  # these are the static pages
  #########################################
  match 'list/subscribe' => 'static_pages#subscribe', :as => 'subscribe', :via => :get
  match 'list/unsubscribe' => 'static_pages#unsubscribe', :as => 'unsubscribe', :via => :get
  match 'list/confirmed' => 'static_pages#confirmed', :as => 'confirmed', :via => :get

end
