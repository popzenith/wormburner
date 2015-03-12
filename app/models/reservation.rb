class Reservation < ActiveRecord::Base
  
  #########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :user_id, :course_id, :complete

  #########################################
  # custom
  #########################################
  belongs_to :user
  belongs_to :course
  
end