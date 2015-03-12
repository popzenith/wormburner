class CoursesController < ApplicationController
  before_filter :authenticate_user!

  #########################################
  # index
  #########################################
  def index
    @courses = Course.paginate(page: params[:page], :per_page => 50)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :courses=>@courses.as_json() 
      } }
    end
  end

  #########################################
  # show
  #########################################
  def show
    @course = Course.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :course=>@course.as_json() 
      } }
    end
  end

end