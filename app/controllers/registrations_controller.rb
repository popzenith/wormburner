class RegistrationsController < Devise::RegistrationsController
  
  respond_to :json, :html
  
  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters

  # overriding this one so you don't need to enter password, you are already logged in
  def update
    
    # required for settings form to submit when password is left blank
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    @user = User.find(current_user.id)

    Rails.logger.debug(params[:user]) 

    if @user.update_attributes(params[:user])
      set_flash_message :notice, :updated
      
      # Sign in the user bypassing validation in case his password changed
      respond_to do |format|
        format.html { 
          sign_in @user, :bypass => true
          redirect_to after_update_path_for(@user)
        }
        format.json  { render :json=> { 
          :user=>@user.as_json(:only => [:id, :name, :email], :methods => [:photo_url]) 
        } }
      end
    else
      render "edit"
    end
  end

  # for inviting

  around_filter :destroy_if_previously_invited, :only => :create

  private

  def destroy_if_previously_invited
    invitation_info = {}

    user_hash = params[:user]
    if user_hash && user_hash[:email]
      @user = User.find_by_email_and_encrypted_password(user_hash[:email], '')
      if @user
        invitation_info[:invitation_sent_at] = @user[:invitation_sent_at]
        invitation_info[:invited_by_id] = @user[:invited_by_id]
        invitation_info[:invited_by_type] = @user[:invited_by_type]
        @user.destroy
      end
    end

    # execute the action (create)
    yield
    # Note that the after_filter is executed at THIS position !

    # Restore info about the last invitation (for later reference)
    # Reset the invitation_info only, if invited_by_id is still nil at this stage:
    @user = User.find_by_email_and_invited_by_id(user_hash[:email], nil)
    if @user
      @user[:invitation_sent_at] = invitation_info[:invitation_sent_at]
      @user[:invited_by_id] = invitation_info[:invited_by_id]
      @user[:invited_by_type] = invitation_info[:invited_by_type]
      @user.save!
    end
  end

  protected
 
  # my custom fields are :name
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:name, :email, :password, :password_confirmation, :current_password)
    end
  end

end




