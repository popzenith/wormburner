class EventsController < ApplicationController
  before_filter :authenticate_user!

  #########################################
  # create 
  #########################################
  def create
    @user = current_user
    @event = @user.events.build(params[:event])
    if @user.save
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json=> { 
          :event=>@event.as_json(
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
  end

  def adduser
    @event = Event.find(params[:id])
    @user = User.find(params[:user][:id])
    @event.users << @user
    if @event.save
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json=> { 
          :event=>@event.as_json(
            :include => { 
              :users => { :only => [:id, :name, :invitation_token, :notify, :buddy, :gender, :displayname], :methods => [:photo_url] },
              :rounds => { }
            }
          )
        } }
      end
    end
  end

  def addnewuser
    @event = Event.find(params[:id])
    @user = @event.users.build params[:user]
    if @event.save
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json=> { 
          :event=>@event.as_json(
            :include => { 
              :users => { :only => [:id, :name, :invitation_token, :notify, :buddy, :gender, :displayname], :methods => [:photo_url] },
              :rounds => { }
            }
          )
        } }
      end
    end
  end
  
  def createround
    @event = Event.find(params[:id])
    @round = @event.rounds.build(params[:round])
    if @event.save
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json=> { 
    		  :round=>@round.as_json(
      			:include => { 
      			  :holes => { },
      			  :scorecard => { },
      			  :event => { }
      			}
      		)
      	} }
      end
    end
  end

  #########################################
  # update
  #########################################
  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json=> { 
          :event=>@event.as_json(
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
  end

  #########################################
  # show
  #########################################
  def show
    @event = Event.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :event=>@event.as_json(
          :include => { 
            :users => { :only => [:id, :name, :invitation_token, :notify, :buddy, :gender, :displayname], :methods => [:photo_url] },
            :rounds => { 
              :include => { 
                :holes => { },
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

  #########################################
  # destroy
  #########################################
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> @event.as_json() } 
    end
  end

end