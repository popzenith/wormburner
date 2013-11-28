class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :correct_user,   only: :destroy

  #########################################
  # main
  #########################################

  # full list of users
  def index
    authorize! :index, @user, :message => 'Oops! Not authorized as an administrator.'
    @users = User.paginate(page: params[:page], :per_page => 50)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @users.to_json }
    end
  end

  # search user names
  def search
    
    # get search term
    if params[:search].nil?
      @users = []
    else 
      @users = User.search(params[:search])
      if @users.nil?
        @users = []
      end
    end

    # find
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :users=>@users.as_json(:only => [:id, :name, :invitation_token], :methods => [:photo_url], :include => {:reverse_relationships => { :only => [:id, :followed_id, :follower_id, :status ] }} )
        } }
    end
  end

  # friend requests
  def friendrequests
    @title = "Friend Requests"
    @user = User.find(params[:id])
    @users = @user.friend_requests
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :users=>@users.as_json(:only => [:id, :name], :methods => [:photo_url], :include => {:relationships => { :only => [:id, :followed_id, :follower_id, :status ] }} )
        } }
    end
  end

  # search one user email
  def searchemail
    
    # get search term
    if params[:email].nil?
      @user = []
    else 
      @user = User.find_by_email(params[:email])
      if @user.nil?
        @user = []
      end
    end

    # find
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :email, :invitation_token], :methods => [:photo_url], :include => {:reverse_relationships => { :only => [:id, :followed_id, :follower_id, :status ] }} )
        } }
    end
  end

  # for checking valid token and download user
  def valid
    @user = current_user
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :email], :methods => [:photo_url]) 
      } }
    end
  end

  # this method is PUT users#update at users/id.json
  # but to update a user use PUT registrations#update at users.json, custom devise method in registrations_controller.rb
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :email], :methods => [:photo_url]) 
      } }
    end
  end

  #########################################
  # general info about any user
  #########################################

  # any user friends posts feed - for home tab
  def feed
    @title = "Feed"
    @user = User.find(params[:id])
    @feed_items = @user.feed.paginate(page: params[:page], :per_page => 50)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :feed_items=>@feed_items.as_json(:only => [:content, :created_at], :methods => [:photo_url], 
          :include => { 
            :user => { :only => [:id, :name], :methods => [:photo_url] }
          }
        )
      } }
    end
  end

  # viewing user profiles (user detaiL)
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => {
        :user=>@user.as_json(:only => [:id, :name], :methods => [:photo_url], :include => {:reverse_relationships => { :only => [:id, :followed_id, :follower_id, :status ] }} )
      } }
    end
  end

  # viewing user profiles (feed)
  def microposts
    @title = "Microposts"
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], :per_page => 50).as_json(:only => [:content, :created_at], :methods => [:photo_url], 
      :include => { 
        :user => { :only => [:id, :name], :methods => [:photo_url] }
      }
    )
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => {
        :microposts=>@microposts.as_json()
      } }
    end
  end

  # any user following
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page], :per_page => 50, :order => "name ASC")
    respond_to do |format|
      format.html { render 'show_follow' }
      format.json  { render :json=> { 
        :followed_users=>@users.as_json(:only => [:id, :name], :methods => [:photo_url]) 
        } }
    end
  end

  # any user followers
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], :per_page => 50, :order => "name ASC")
    respond_to do |format|
      format.html { render 'show_follow' }
      format.json  { render :json=> { 
        :followers=>@users.as_json(:only => [:id, :name], :methods => [:photo_url] ) 
        } }
    end
  end

  # combined
  def friends
    @title = "Friends"
    @user = User.find(params[:id])
    @friends = @user.followed_users.all() | @user.followers.all()
    @friends.sort! { |a,b| a.name.downcase <=> b.name.downcase }
    @friends = @friends.paginate(page: params[:page], :per_page => 50)
    respond_to do |format|
      format.html { render 'show_follow' }
      format.json  { render :json=> { 
        :friends=>@friends.as_json(:only => [:id, :name], :methods => [:photo_url] ) 
        } }
    end
  end
end
