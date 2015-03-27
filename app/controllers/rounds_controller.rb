class RoundsController < ApplicationController
  before_filter :authenticate_user!

  #########################################
  # index
  #########################################
  def index
    @rounds = Round.paginate(page: params[:page], :per_page => 50)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :rounds=>@rounds.as_json()
      } }
    end
  end

  #########################################
  # create
  #########################################
  def createhole
    @round = Round.find(params[:id])
    @hole = @round.holes.build(params[:hole])
    if @round.save
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json=> { 
        :round=>@round.as_json( 
          :include => { 
            :holes => { }  
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
    @round = Round.find(params[:id])
    if @round.update_attributes(params[:round])
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json=> { 
          :round=>@round.as_json()
        } }
      end
    end
  end

  #########################################
  # show
  #########################################
  def show
    @round = Round.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :round=>@round.as_json(
          :include => { 
            :holes => {  }  
          }
        )
      } }
    end
  end

end