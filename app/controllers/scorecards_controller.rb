class ScorecardsController < ApplicationController
  before_filter :authenticate_user!

  #########################################
  # index
  #########################################
  def index
    @scorecards = Scorecard.paginate(page: params[:page], :per_page => 50)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :scorecards=>@scorecards.as_json() 
      } }
    end
  end

  #########################################
  # show
  #########################################
  def show
    @scorecard = Scorecard.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :scorecard=>@scorecard.as_json() 
      } }
    end
  end

end