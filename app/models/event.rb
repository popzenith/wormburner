class Event < ActiveRecord::Base

  #########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :course_id, :user_id, :complete, :playdate
  
  #########################################
  # custom
  #########################################
  belongs_to :course
  has_many :rounds
  has_many :user_events
  has_many :users, through: :user_events
  
end

