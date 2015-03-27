class PromosController < ApplicationController
  before_filter :authenticate_user!

  #########################################
  # index
  #########################################
  def index
    @promos = Promo.paginate(page: params[:page], :per_page => 50)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :promos=>@promos.as_json() 
      } }
    end
  end

  #########################################
  # show
  #########################################
  def show
    @promo = Promo.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :promo=>@promo.as_json() 
      } }
    end
  end

end