class HolesController < ApplicationController
  before_filter :authenticate_user!

  #########################################
  # index
  #########################################
  def index
    @holes = Hole.paginate(page: params[:page], :per_page => 50)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :holes=>@holes.as_json()
      } }
    end
  end

  #########################################
  # update
  #########################################
  def update
    @hole = Hole.find(params[:id])
    if @hole.update_attributes(params[:hole])
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json=> { 
          :hole=>@hole.as_json()
        } }
      end
    end
  end

end