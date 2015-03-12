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
        :users=>@users.as_json(:only => [:id, :name, :invitation_token, :notify, :handicap], :methods => [:photo_url]) 
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
        :user=>@user.as_json(:only => [:id, :name, :email, :invitation_token, :notify, :handicap], :methods => [:photo_url]) 
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
        :user=>@user.as_json(:only => [:id, :name, :email, :invitation_token, :notify, :handicap], :methods => [:photo_url])  
      } }
    end
  end

  #########################################
  # activity
  #########################################

  # viewing user profiles (user detaiL)
  def show
    @title = ""

    puts '====================== show'

    @user = User.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :invitation_token, :notify, :handicap], :methods => [:photo_url]) 
      } }
    end
  end

  # user events
  def events
    @title = "My Events"

    puts '====================== events'

    @user = User.find(params[:id])
    @events = @user.events.paginate(page: params[:page], :per_page => 50)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :events=>@events.as_json(:only => [:id, :course_id, :complete, :playdate], 
          :include => { 
            :users => { :only => [:id, :name, :invitation_token, :notify, :handicap], :methods => [:photo_url] },
            :rounds => { },
            :course => { }  
          }
        )
      } }
    end
  end
  
  # user events in progress
  def eventsinprogress
    @title = "My Events In Progress"

    puts '====================== events'

    @user = User.find(params[:id])
    @events = @user.events.where(complete: 'inprogress').paginate(page: params[:page], :per_page => 50)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :events=>@events.as_json(:only => [:id, :course_id, :complete, :playdate], 
          :include => { 
            :users => { :only => [:id, :name, :invitation_token, :notify, :handicap], :methods => [:photo_url] },
            :rounds => { },
            :course => { }  
          }
        )
      } }
    end
  end
  
  # user rounds (for stats, easier access than downloading events)
  def rounds
    @title = "My Rounds"

    puts '====================== rounds'

    @user = User.find(params[:id])
    @rounds = @user.rounds.paginate(page: params[:page], :per_page => 50)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :rounds=>@rounds.as_json(:only => [:id, :created_at, :user_id, :event_id, :tee, :score_front, :score_back, :score_total, :handicap_used], 
          :include => { 
            :holes => { }
          }
        )
      } }
    end
  end
  
end
