class UserEvent < ActiveRecord::Base

  #########################################
  # Setup accessible (or protected) attributes for your model
  #########################################
  attr_accessible :user_id, :event_id

  #########################################
  # refers to the join
  #########################################
  belongs_to :user
  belongs_to :event
end
