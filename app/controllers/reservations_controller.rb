class ReservationsController < ApplicationController
  before_filter :authenticate_user!

  #########################################
  # index
  #########################################
  def index
    @reservations = Reservation.paginate(page: params[:page], :per_page => 50)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :reservations=>@reservations.as_json()
      } }
    end
  end


  #########################################
  # show
  #########################################
  def show
    @reservation = Reservation.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :reservation=>@reservation.as_json()
      } }
    end
  end

end