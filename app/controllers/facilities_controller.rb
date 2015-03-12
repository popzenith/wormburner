class FacilitiesController < ApplicationController
  before_filter :authenticate_user!

  #########################################
  # index
  #########################################
  def index
    @facilities = Facility.paginate(page: params[:page], :per_page => 50)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :facilities=>@facilities.as_json() 
      } }
    end
  end

  #########################################
  # show
  #########################################
  def show
    @facility = Facility.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :facility=>@facility.as_json(:only => [:id, :facility_code, :facility_name, :address, :city, :state, :longitude, :latitude], 
          :include => { 
            :courses => { :only => [:id, :course_code, :facility_code, :course_name, :hol, :par],
              :include => { 
                :scorecards => { }
              }
            } 
          }
        )  
      } }
    end
  end

end