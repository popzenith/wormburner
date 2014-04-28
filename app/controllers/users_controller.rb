class UsersController < ApplicationController
  before_filter :authenticate_user!

  #########################################
  # main
  #########################################

  # full list of users
  def index

    puts '====================== index'

    authorize! :index, @user, :message => 'Oops! Not authorized as an administrator.'
    @users = User.paginate(page: params[:page], :per_page => 50).order('lower(name) ASC')
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @users.to_json }
    end
  end

  # search user names
  def search
    
    puts '====================== search'

    # get search term
    if params[:search].nil?
      @users = []
    else 
      @users = User.search(params[:search]).limit(50).order('lower(name) ASC')
      if @users.nil?
        @users = []
      end
    end

    # find
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :users=>@users.as_json(:only => [:id, :name, :invitation_token, :notify], :methods => [:photo_url]) 
      } }
    end
  end

  # search one user email
  def searchemail
    
    puts '====================== searchemail'

    # get search term
    if params[:user][:email].nil?
      @user = []
    else 
      #@user = User.find_by_email(params[:user][:email])
      @user = User.searchbyemail(params[:user][:email])
      if @user.nil?
        @user = []
      end
    end

    # find
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :email, :invitation_token, :notify], :methods => [:photo_url]) 
      } }
    end
  end

  # for checking valid token and download user
  def valid

    puts '====================== valid'

    @user = current_user
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :email, :invitation_token, :notify], :methods => [:photo_url]) 
      } }
    end
  end

  #########################################
  # general info about any user
  #########################################

  # any user friends posts feed - for home tab
  def feed
    @title = "Latest Posts"

    puts '====================== feed'

    @user = User.find(params[:id])
    @feed_items = @user.feed.paginate(page: params[:page], :per_page => 50).includes(:user, :venue, :users)
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

  # viewing user profiles (user detaiL)
  def show
    @title = ""

    puts '====================== show'

    @user = User.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :invitation_token, :notify], :methods => [:photo_url]) 
      } }
    end
  end

  # update notify (updates superuser)
  def refreshnotify
    @title = ""

    puts '====================== refreshnotify'

    current_user.update_attributes!(:notify => "NO")
    @user = current_user
    
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :email, :invitation_token, :notify], :methods => [:photo_url])  
      } }
    end
  end

  # viewing user profiles (feed)
  def microposts
    @title = "Latest Posts"

    puts '====================== microposts'

    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], :per_page => 50).includes(:user, :venue, :users)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :microposts=>@microposts.as_json(:only => [:id, :content, :created_at], :methods => [:photo_url], 
          :include => { 
            :user => { :only => [:id, :name], :methods => [:photo_url] },
            :venue => { :only => [:id, :name] },
            :users => { :only => [:id, :name], :methods => [:photo_url] }  
          }
        )
      } }
    end
  end

  # any user favorite venues
  def venues
    @title = "Venues"

    puts '====================== venues'

    @user = User.find(params[:id])
    @venues = @user.venues.paginate(page: params[:page], :per_page => 50)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :venues=>@venues.as_json(:only => [:id, :name],) 
      } }
    end
  end

  #########################################
  # relationships
  #########################################

  # any user following
  def following
    @title = "Following"

    puts '====================== following'

    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page], :per_page => 50).order('lower(name) ASC')
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :followed_users=>@users.as_json(:only => [:id, :name, :invitation_token, :notify]) 
      } }
    end
  end

  def following_count
    @fcount = User.find(params[:id]).followed_users.count
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :modelcount=>@fcount.as_json() 
        } }
    end
  end

  # any user followers
  def followers
    @title = "Followers"

    puts '====================== followers'

    @users = User.find(params[:id]).followers.paginate(page: params[:page], :per_page => 50).order('lower(name) ASC')


    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :followers=>@users.as_json(:only => [:id, :name, :invitation_token, :notify], :methods => [:photo_url]) 
      } }
    end
  end

  def followers_count
    @fcount = User.find(params[:id]).followers.count
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :modelcount=>@fcount.as_json() 
        } }
    end
  end

  # recent followers
  def recentfollowers
    @title = "Recent Followers"

    puts '====================== followers'

    @users = User.find(params[:id]).followers.paginate(page: params[:page], :per_page => 50).order('relationships.updated_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :followers=>@users.as_json(:only => [:id, :name, :invitation_token, :notify], :methods => [:photo_url]) 
      } }
    end
  end

  # friend requests
  def friendrequests
    @title = "Friend Requests"
    
    puts '====================== friendrequests'

    @users = current_user.friendrequests.limit(50).order('relationships.updated_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :followers=>@users.as_json(:only => [:id, :name, :invitation_token, :notify], :methods => [:photo_url]) 
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
        :friends=>@friends.as_json(:only => [:id, :name, :invitation_token, :notify], :methods => [:photo_url]) 
      } }
    end
  end

  # count
  def friends_count
    @followerscount = User.find(params[:id]).followers.count
    @followingcount = User.find(params[:id]).following.count
    @friendscount = @followerscount + @followingcount
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :modelcount=>@friendscount.as_json() 
        } }
    end
  end

  # check relationship
  def myrelationship

    puts '====================== myrelationship'

    user = User.find(params[:id])
    @relationship = current_user.following?(user)
    if @relationship.nil?
      @relationship = []
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :relationship=>@relationship.as_json() 
      } }
    end
  end

  # check reverse relationship
  def myreverserelationship

    puts '====================== myrelationship'

    user = User.find(params[:id])
    @relationship = user.following?(current_user)
    if @relationship.nil?
      @relationship = []
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :relationship=>@relationship.as_json() 
      } }
    end
  end

  # email someone already in the system
  def invitationemailonly

    puts '====================== invitationemailonly'

    # get user
    @user = User.find(params[:id])
    @email = @user[:email]

    # message object
    @message = {}
    @message = params[:message]
    @name = params[:message][:name]
    #@message.name = params[:message][:name]
    @message[:email] = @email
    @message[:subject] = "Let's Have a Drink..."
    @message[:body] = "
    <p>Hello #{@email}!</p>
    <br/>
    <p>#{@name} has invited you to try out GolfPals, a new app for iPhone.</p>
    <p>You’ll be able to plan outings with your friends, make tee times, and post your scores and photos.</p>
    <br/>
    <p>Learn more and download the app for iPhone at <a href='https://www.golfpals.co'>golfpals.co</a>.</p>"

    # send email
    @sendmessage = Message.new(@message)
    if @sendmessage.valid?
      InvitationsMailer.new_message(@sendmessage).deliver
    end 
    
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :email, :invitation_token, :notify], :methods => [:photo_url])
      } }
    end
  end

  #########################################
  # block a user
  #########################################
  def blockuser

    # other user
    @user = User.find(params[:id])
    @relationship = @user.following?(current_user)
    if @relationship.nil?
      
      # create relationship
      @user.follow!(current_user, params[:relationship][:status])
    else

      # update
      @relationship.update_attributes!(:status => params[:relationship][:status])
      @user = User.find(@relationship.followed_id)
    end

    # done
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :email, :invitation_token, :notify], :methods => [:photo_url])
      } }
    end
  end
  
end
