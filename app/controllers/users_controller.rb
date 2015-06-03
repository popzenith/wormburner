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

  # for checking valid token and download user
  def valid

    puts '====================== valid'

    @user = current_user
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :email, :invitation_token, :notify, :buddy, :gender, :displayname], :methods => [:photo_url]) 
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
        :user=>@user.as_json(:only => [:id, :name, :email, :invitation_token, :notify, :buddy, :gender, :displayname], :methods => [:photo_url])  
      } }
    end
  end

  #########################################
  # search
  #########################################
  def search
    
    puts '====================== search'

    # get search term
    if params[:search].nil?
      @users = []
    else 
      @users = User.search(params[:search]).limit(50).order('lower(name) ASC').where.not(buddy: 'FAKE')
      if @users.nil?
        @users = []
      end
    end

    # find
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :users=>@users.as_json(:only => [:id, :name, :invitation_token, :notify, :notify, :buddy, :gender, :displayname], :methods => [:photo_url]) 
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
        :user=>@user.as_json(:only => [:id, :name, :invitation_token, :notify, :buddy, :gender, :displayname], :methods => [:photo_url],
          :include => { 
            :rounds => { }
          }
        ) 
      } }
    end
  end

  # user events
  def events
    @title = "My Events"

    puts '====================== events'

    @user = User.find(params[:id])
    @events = @user.events.where(complete: 'Y').paginate(page: params[:page], :per_page => 50)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :events=>@events.as_json(
          :include => { 
            :users => { :only => [:id, :name, :invitation_token, :notify, :buddy, :gender, :displayname], :methods => [:photo_url] },
            :rounds => { 
              :include => { 
                :scorecard => { }
              }
            },
            :course => {
              :include => {
                :facility => { :only => [:id, :facility_code, :facility_name, :address, :city, :state, :longitude, :latitude], 
                  :include => { 
                    :courses => { :only => [:id, :course_code, :facility_code, :course_name, :hol, :par] }
                  }
                }
              } 
            }  
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
    @events = @user.events.where(complete: 'INPROGRESS').paginate(page: params[:page], :per_page => 50)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :events=>@events.as_json(
          :include => { 
            :users => { :only => [:id, :name, :invitation_token, :notify, :buddy, :gender, :displayname], :methods => [:photo_url] },
            :rounds => { 
              :include => { 
                :scorecard => { }
              }
            },
            :course => {
              :include => {
                :facility => { :only => [:id, :facility_code, :facility_name, :address, :city, :state, :longitude, :latitude], 
                  :include => { 
                    :courses => { :only => [:id, :course_code, :facility_code, :course_name, :hol, :par] }
                  }
                }
              } 
            }  
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
    #@rounds = @user.rounds.where(complete: 'Y').paginate(page: params[:page], :per_page => 50)
    @rounds = @user.rounds.paginate(page: params[:page], :per_page => 50)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :rounds=>@rounds.as_json(
          :include => { 
            :holes => { },
            :scorecard => { },
            :event => { 
              :include => { 
                :course => {
                  :include => {
                    :facility => { :only => [:id, :facility_code, :facility_name, :address, :city, :state, :longitude, :latitude], 
                      :include => { 
                        :courses => { :only => [:id, :course_code, :facility_code, :course_name, :hol, :par] }
                      }
                    }
                  } 
                }  
              }
            }
          }
        )
      } }
    end
  end

  # email visualization pdf
  def posteremail

    puts '====================== posteremail'

    # get user
    @user = User.find(params[:id])
    @email = @user[:email]

    # message object
    @message = {}
    @message = params[:message]
    @pdfurl = params[:message][:pdf_url]
    @message[:email] = @email
    @message[:subject] = "Your WormBurner Stats Visualization"
    @message[:body] = "
    <p>Hello #{@email}!</p>
    <br/>
    <p>Download your WormBurner stats visualization here:</p>
    <br/>
    <p>#{@pdfurl}</p>
    <br/>
    <p>Keep playing and get some more birdies on there!</p>"

    # send email
    @sendmessage = Message.new(@message)
    if @sendmessage.valid?
      PosterMailer.new_message(@sendmessage).deliver
    end 
    
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json( :only => [:id, :name, :invitation_token, :notify, :buddy, :gender, :displayname], :methods => [:photo_url, :pdf_url] )
        } }
    end
  end

end
