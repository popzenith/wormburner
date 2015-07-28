class FacilitiesController < ApplicationController
  before_filter :authenticate_user!

  #########################################
  # index
  #########################################
  def index
    #@facilities = Facility.paginate(page: params[:page], :per_page => 50).order('lower(facility_name) ASC')
    @facilities = Facility.by_distance(:origin => [params[:latitude],params[:longitude]]).limit(50)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :facilities=>@facilities.as_json(:only => [:id, :facility_code, :facility_name, :address, :city, :state, :longitude, :latitude], 
          :include => { 
            :courses => { :only => [:id, :course_code, :facility_code, :course_name, :hol, :par],
              :include => { 
                :scorecards => { :only => [:id] }
              }
            } 
          }
        )  
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
      @facilities = []
    else 
      @facilities = Facility.by_distance(:origin => [params[:latitude],params[:longitude]]).limit(50).search(params[:search])
      #@facilities = Facility.where('lower(facility_name) LIKE ?', params[:search]).limit(50)
      if @facilities.nil?
        @facilities = []
      end
    end

    # find
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :facilities=>@facilities.as_json(:only => [:id, :facility_code, :facility_name, :address, :city, :state, :longitude, :latitude], 
          :include => { 
            :courses => { :only => [:id, :course_code, :facility_code, :course_name, :hol, :par],
              :include => { 
                :scorecards => { :only => :id } 
              }
            } 
          }
        )  
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