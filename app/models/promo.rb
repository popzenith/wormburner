class Promo < ActiveRecord::Base
  
  #########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :user_id, :course_id, :content, :photo, :link

  #########################################
  # custom
  #########################################
  belongs_to :user
  belongs_to :course
  
  #########################################
  # paperclip profile photo
  #########################################
  has_attached_file :photo, :styles => { :small => "300x300#" },
                            :default_url => 'missing_:style.png'

  #########################################
  # these methods can be called from the controller to get data from other models 
  # look in the controller and see these get called 
  #########################################      

  # profile photos
  def photo_url
    photo.url(:small)
  end
end