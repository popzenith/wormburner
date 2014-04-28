class VenuesController < ApplicationController
  before_filter :authenticate_user!

  #########################################
  # lists all the venues that we have saved, not actually used
  #########################################
  def index
    @venues = Venue.paginate(page: params[:page], :per_page => 50).order('lower(name) ASC')
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :venues=>@venues.as_json(:only => [:id, :name]) 
      } }
    end
  end

  #########################################
  # venue tagged in posts
  #########################################
  def feed 
    @venue = Venue.find(params[:id])
    @feed_items = @venue.feed.paginate(page: params[:page], :per_page => 50).includes(:user, :venue, :users)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :feed_items=>@feed_items.as_json(:only => [:id, :content, :created_at], :methods => [:photo_url], 
          :include => { 
            :user => { :only => [:id, :name], :methods => [:photo_url] },
            :venue => { :only => [:id, :name] },
            :users => { :only => [:id, :name], :methods => [:photo_url] }  
          }
        )
      } }
    end
  end
  
  #########################################
  # venue info
  #########################################
  def show
    @venue = Venue.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :venue=>@venue.as_json(:only => [:id, :name]) 
      } }
    end
  end

  #########################################
  # accesses favorite join table
  #########################################
  def favorite
    @venue = Venue.find(params[:id])
    current_user.favorite!(@venue)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :venue=>@venue.as_json(:only => [:id, :name]) 
      } }
    end
  end

  #########################################
  # accesses favorite join table
  #########################################
  def unfavorite
    @venue = Venue.find(params[:id])
    current_user.unfavorite!(@venue)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :venue=>@venue.as_json(:only => [:id, :name]) 
      } }
    end
  end

end